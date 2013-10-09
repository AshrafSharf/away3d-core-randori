/**
 * ...
 * @author Away3D Team - http://away3d.com/team/ (Original Development)
 * @author Karim Beyrouti - http://kurst.co.uk/ (ActionScript to TypeScript port)
 * @author Gary Paluk - http://www.plugin.io/ (ActionScript to TypeScript port)
 * @author Pete Shand - http://www.peteshand.net/ (TypeScript to Randori port)
 */

package aglsl.assembler
{
    public class OpcodeMap
    {
        // dest:					  					   string,  aformat, asize, bformat,   bsize, opcode, simple, horizontal, fragonly   matrix
        /*


        private static var _map:Vector.<Object>;

        public static function get map():Vector.<Object>
        {

            if ( ! OpcodeMap._map )
            {

                OpcodeMap._map = new Vector.<Object>();
                OpcodeMap._map['mov'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x00,   true,   null,       null,      null );
                OpcodeMap._map['add'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x01,   true,   null,       null,      null );
                OpcodeMap._map['sub'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x02,   true,   null,       null,      null );
                OpcodeMap._map['mul'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x03,   true,   null,       null,      null );
                OpcodeMap._map['div'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x04,   true,   null,       null,      null );
                OpcodeMap._map['rcp'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x05,   true,   null,       null,      null );
                OpcodeMap._map['min'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x06,   true,   null,       null,      null );
                OpcodeMap._map['max'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x07,   true,   null,       null,      null );
                OpcodeMap._map['frc'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x08,   true,   null,       null,      null );
                OpcodeMap._map['sqt'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x09,   true,   null,       null,      null );
                OpcodeMap._map['rsq'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x0a,   true,   null,       null,      null );
                OpcodeMap._map['pow'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x0b,   true,   null,       null,      null );
                OpcodeMap._map['log'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x0c,   true,   null,       null,      null );
                OpcodeMap._map['exp'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x0d,   true,   null,       null,      null );
                OpcodeMap._map['nrm'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x0e,   true,   null,       null,      null );
                OpcodeMap._map['sin'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x0f,   true,   null,       null,      null );
                OpcodeMap._map['cos'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x10,   true,   null,       null,      null );
                OpcodeMap._map['crs'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x11,   true,   true,       null,      null );
                OpcodeMap._map['dp3'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x12,   true,   true,       null,      null );
                OpcodeMap._map['dp4'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x13,   true,   true,       null,      null );
                OpcodeMap._map['abs'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x14,   true,   null,       null,      null );
                OpcodeMap._map['neg'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x15,   true,   null,       null,      null );
                OpcodeMap._map['sat'] = new Opcode( "vector", "vector", 4,    "none",    0,     0x16,   true,   null,       null,      null );

                OpcodeMap._map['ted'] = new Opcode( "vector", "vector", 4,    "sampler", 1,     0x26,   true,   null,       true,      null );
                OpcodeMap._map['kil'] = new Opcode( "none",   "scalar", 1,    "none",    0,     0x27,   true,   null,       true,      null );
                OpcodeMap._map['tex'] = new Opcode( "vector", "vector", 4,    "sampler", 1,     0x28,   true,   null,       true,      null );

                OpcodeMap._map['m33'] = new Opcode( "vector", "matrix", 3,    "vector",  3,     0x17,   true,   null,       null,      true );
                OpcodeMap._map['m44'] = new Opcode( "vector", "matrix", 4,    "vector",  4,     0x18,   true,   null,       null,      true );
                OpcodeMap._map['m43'] = new Opcode( "vector", "matrix", 3,    "vector",  4,     0x19,   true,   null,       null,      true );

                OpcodeMap._map['sge'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x29,   true,   null,       null,      null );
                OpcodeMap._map['slt'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x2a,   true,   null,       null,      null );
                OpcodeMap._map['sgn'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x2b,   true,   null,       null,      null );
                OpcodeMap._map['seq'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x2c,   true,   null,       null,      null );
                OpcodeMap._map['sne'] = new Opcode( "vector", "vector", 4,    "vector",  4,     0x2d,   true,   null,       null,      null );


            }

            return OpcodeMap._map;

        }



        public function OpcodeMap():void
        {
        }
    }
}