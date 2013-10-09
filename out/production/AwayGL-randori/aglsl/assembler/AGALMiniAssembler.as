/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package aglsl.assembler
{
	import randori.webkit.page.Window;
	public class AGALMiniAssembler
	{
		
		public var r:Object;
		public var cur:Part;
		
		public function AGALMiniAssembler():void
		{
			this.r = {};
			this.cur = new Part();
		}
		
		public function assemble(source:String, ext_part:String = null, ext_version:Number = 1):Object
		{
			ext_part = ext_part || null;
			ext_version = ext_version || 1;

			if( !ext_version )
			{
				ext_version = 1;
			}
			
			if( ext_part )
			{
				this.addHeader( ext_part, ext_version );
			}
			
			var lines = source.replace( /[\f\n\r\v]+/g, "\n" ).split( "\n" ); // handle breaks, then split into lines        
			
			for( var i in lines )
			{
				this.processLine( lines[i], i );
			}
			
			return this.r;
		}
		
		private function processLine(line:String, linenr:Number):void
		{            
			var startcomment = line.search( "//" );  // remove comments
			if ( startcomment != -1 )
			{
				line = line.slice( 0, startcomment );
			}
			line = line.replace( /^\s+|\s+$/g, "" ); // remove outer space
			if ( !(line.length > 0 ) )
			{
				return;
			}
			var optsi = line.search( /<.*>/g ); // split of options part <*> if there
			var opts = null;
			if ( optsi != -1 )
			{
				opts = line.slice( optsi ).match( /([\w\.\-\+]+)/gi );
				line = line.slice( 0, optsi );
			}
			
			// get opcode/command				            
			var tokens = line.match( /([\w\.\+\[\]]+)/gi ); // get tokens in line
			if ( !tokens || tokens.length<1 )
			{
				if ( line.length >= 3 )
				{
					Window.console.log ( "Warning: bad line "+linenr+": "+line );
				}
				return;
			}
			
			//console.log ( linenr, line, cur, tokens ); 
			switch ( tokens[0] )
			{
				case "part":
					this.addHeader( tokens[1], Number(tokens[2]) ); 
					break;                
				case "endpart":
					if ( !this.cur )
					{
						throw "Unexpected endpart";
					}
					this.cur.data.position = 0;
					this.cur = null; 
					return; 
				default: 
					if( !this.cur )
					{
						Window.console.log( "Warning: bad line "+linenr+": "+line+" (Outside of any part definition)" );
						return; 
					}
					if ( this.cur.name == "comment" )
					{
						return;
					}
					var op: Opcode = (OpcodeMap.map( )[tokens[0]] as Opcode);
					if ( !op )
					{
						throw "Bad opcode "+tokens[0]+" "+linenr+": "+line;
					}
                    // console.log( 'AGALMiniAssembler' , 'op' , op );
					
					this.emitOpcode ( this.cur, op.opcode );
					var ti:Number = 1; 
					if ( op.dest && op.dest!="none" )
					{
						if ( !this.emitDest ( this.cur, tokens[ti++], op.dest ) )
						{
							throw "Bad destination register "+tokens[ti-1]+" "+linenr+": "+line;
						}
					}
					else 
					{
						this.emitZeroDword( this.cur );
					}
					
					if ( op.a && op.a.format!="none" )
					{
						if ( !this.emitSource( this.cur, tokens[ti++], op.a ) ) throw "Bad source register "+tokens[ti-1]+" "+linenr+": "+line; 
					}
					else
					{
						this.emitZeroQword( this.cur ); 
					}
					
					if ( op.b && op.b.format!="none" )
					{
						if ( op.b.format == "sampler" )
						{
							if( !this.emitSampler( this.cur, tokens[ti++], op.b, opts ) )
							{
								throw "Bad sampler register "+tokens[ti-1]+" "+linenr+": "+line;
							}
						}
						else
						{
							if ( !this.emitSource( this.cur, tokens[ti++], op.b ) )
							{
								throw "Bad source register " + tokens[ti-1] + " " + linenr + ": " + line;
							}
						}
					}
					else
					{
						this.emitZeroQword( this.cur ); 
					}
					break;
			}                			                                             
		}
		
		public function emitHeader(pr:Part):void
		{
			pr.data.writeUnsignedByte( 0xa0 ); 	// tag version
			pr.data.writeUnsignedInt( pr.version ); 
			if( pr.version >= 0x10 )
			{
				pr.data.writeUnsignedByte ( 0 ); // align, for higher versions
			}
			pr.data.writeUnsignedByte ( 0xa1 );		// tag program id
			switch( pr.name )
			{
				case "fragment" : pr.data.writeUnsignedByte ( 1 ); break;
				case "vertex" : pr.data.writeUnsignedByte ( 0 ); break;
				case "cpu" : pr.data.writeUnsignedByte ( 2 ); break;
				default : pr.data.writeUnsignedByte ( 0xff ); break; // unknown/comment
			}                        
		}    
		
		public function emitOpcode(pr:Part, opcode):void
		{
			pr.data.writeUnsignedInt( opcode );
			//console.log ( "Emit opcode: ", opcode ); 
		}
		
		public function emitZeroDword(pr:Part):void
		{
			pr.data.writeUnsignedInt( 0 );
		}
		
		public function emitZeroQword(pr):void
		{
			pr.data.writeUnsignedInt( 0 );
			pr.data.writeUnsignedInt( 0 );
		}
		
		public function emitDest(pr, token, opdest):Boolean
		{
			
            //console.log( 'aglsl.assembler.AGALMiniAssembler' , 'emitDest' , 'RegMap.map()' , RegMap.map());           
			var reg = token.match ( /([fov]?[tpocidavs])(\d*)(\.[xyzw]{1,4})?/i ); // g1: regname, g2:regnum, g3:mask
			
			// console.log( 'aglsl.assembler.AGALMiniAssembler' , 'emitDest' , 'reg' , reg , reg[1] , RegMap.map()[reg[1]] );
			// console.log( 'aglsl.assembler.AGALMiniAssembler' , 'emitDest' , 'RegMap.map()[reg[1]]' , RegMap.map()[reg[1]] , 'bool' , !RegMap.map()[reg[1]] ) ;
            
			if ( !RegMap.map()[reg[1]] ) return false;
			var em = { num:reg[2]?reg[2]:0, code:RegMap.map()[reg[1]].code, mask:this.stringToMask(reg[3]) };
			pr.data.writeUnsignedShort ( em.num );
			pr.data.writeUnsignedByte ( em.mask );
			pr.data.writeUnsignedByte ( em.code );
			//console.log ( "  Emit dest: ", em );
			return true;
		}
	
		public function stringToMask(s:String):Number
		{
			if ( !s ) return 0xf; 
			var r = 0;
			if ( s.indexOf ( "x" ) != -1 ) r|=1;
			if ( s.indexOf ( "y" ) != -1 ) r|=2;
			if ( s.indexOf ( "z" ) != -1 ) r|=4;
			if ( s.indexOf ( "w" ) != -1 ) r|=8;
			return r;
		} 
		
		public function stringToSwizzle(s):Number
		{
			if( !s )
			{
				return 0xe4;
			}
			var chartoindex = { x:0, y:1, z:2, w:3 };
			var sw = 0;
			
			if( s.charAt(0) != "." )
			{
				throw "Missing . for swizzle";
			}
			
			if( s.length > 1)
			{
				sw |= chartoindex[s.charAt(1)];
			}
			
			if( s.length > 2 )
			{
				sw |= chartoindex[s.charAt(2)] << 2;
			}
			else
			{
				sw |= (sw&3)<<2;
			}
			
			if( s.length > 3)
			{
				sw |= chartoindex[s.charAt(3)] << 4;
			}
			else
			{
				sw |= (sw&(3<<2))<<2;
			}
			
			if( s.length > 4)
			{
				sw |= chartoindex[s.charAt(4)] << 6;
			}
			else
			{
				sw |= (sw&(3<<4)) << 2;
			}
			
			return sw;
		}
		
		public function emitSampler(pr:Part, token, opsrc, opts):Boolean
		{
			var reg = token.match( /fs(\d*)/i ); // g1:regnum
			if( !reg || !reg[1] )
			{
				return false;
			}
			pr.data.writeUnsignedShort ( reg[1] ); 
			pr.data.writeUnsignedByte ( 0 );   // bias
			pr.data.writeUnsignedByte ( 0 );         
			/*
			var samplerbits:Number = 0x5; 
			var sampleroptset:Number = 0; 
			for ( var i:Number = 0; i < opts.length; i++ )
			{
				var o:aglsl.assembler.Sampler = SamplerMap.map()[opts[i].toLowerCase()] as aglsl.assembler.Sampler;
				
                //console.log( 'AGALMiniAssembler' , 'emitSampler' , 'SampleMap opt:' , o , '<-------- WATCH FOR THIS');
				
				if( o )
				{
					if ( ((sampleroptset >> o.shift) & o.mask) != 0 )
					{
						Window.console.log("Warning, duplicate sampler option");
					}
					sampleroptset |= o.mask << o.shift;
					samplerbits &= ~(o.mask << o.shift);
					samplerbits |= o.value << o.shift;
				}
				else
				{
					Window.console.log("Warning, unknown sampler option: ", opts[i] );
					// todo bias
				}
			}
			pr.data.writeUnsignedInt( samplerbits );             
			return true;
		}
		
		public function emitSource(pr, token, opsrc):Boolean
		{
			var indexed = token.match( /vc\[(v[tcai])(\d+)\.([xyzw])([\+\-]\d+)?\](\.[xyzw]{1,4})?/i ); // g1: indexregname, g2:indexregnum, g3:select, [g4:offset], [g5:swizzle] 
			var reg;
			if( indexed )
			{
				if ( !RegMap.map()[indexed[1]] )
				{
					return false;
				}
				var selindex = { x:0, y:1, z:2, w:3 };
				var em:* = { num:indexed[2]|0, code:RegMap.map()[indexed[1]].code, swizzle:this.stringToSwizzle(indexed[5]), select:selindex[indexed[3]], offset:indexed[4]|0 };
				pr.data.writeUnsignedShort( em.num );
				pr.data.writeByte( em.offset );
				pr.data.writeUnsignedByte( em.swizzle );
				pr.data.writeUnsignedByte( 0x1 ); // constant reg
				pr.data.writeUnsignedByte( em.code );
				pr.data.writeUnsignedByte( em.select );
				pr.data.writeUnsignedByte( 1 << 7 );
			}
			else
			{
				reg = token.match( /([fov]?[tpocidavs])(\d*)(\.[xyzw]{1,4})?/i ); // g1: regname, g2:regnum, g3:swizzle
				if( !RegMap.map()[reg[1]] )
				{
					return false;
				}
				var em : * = { num:reg[2]|0, code:RegMap.map()[reg[1]].code, swizzle:this.stringToSwizzle(reg[3]) };
				pr.data.writeUnsignedShort ( em.num );
				pr.data.writeUnsignedByte ( 0 );
				pr.data.writeUnsignedByte ( em.swizzle );
				pr.data.writeUnsignedByte ( em.code );
				pr.data.writeUnsignedByte ( 0 );
				pr.data.writeUnsignedByte ( 0 );
				pr.data.writeUnsignedByte ( 0 );
				//console.log ( "  Emit source: ", em, pr.data.length );
			}                    
			return true; 
		}  
		
		public function addHeader(partname:String, version:Number):void
		{
			if( !version )
			{
				version = 1;
			}
			if ( this.r[partname] == undefined )
			{
				this.r[partname] = new Part( partname, version );
				this.emitHeader( this.r[ partname ] ); 
			} 
			else if ( this.r[partname].version != version )
			{
				throw "Multiple versions for part " + partname;
			}
			this.cur = this.r[partname]; 
		}
	}
}