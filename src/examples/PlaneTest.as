
package examples
{
import away.core.display.Stage;
import away.core.display.Stage3D;
import away.core.display3D.Context3D;
import away.core.display3D.Context3DTextureFormat;
import away.core.display3D.Context3DVertexBufferFormat;
import away.core.display3D.IndexBuffer3D;
import away.core.display3D.Program3D;
import away.core.display3D.Texture;
import away.core.display3D.VertexBuffer3D;
import away.core.geom.Matrix3D;
import away.core.geom.Vector3D;
import away.core.net.IMGLoader;
import away.core.net.URLRequest;
import away.events.Event;
import away.utils.PerspectiveMatrix3D;

import away.events.Stage3DEvent;
import randori.webkit.html.HTMLImageElement;
import randori.webkit.page.Window;

    public class PlaneTest extends BaseExample
    {
        private var stage:Stage;
        private var stage3D:Stage3D;
        private var context3D:Context3D;

        private var iBuffer:IndexBuffer3D;
        private var program:Program3D;
        private var pMatrix:PerspectiveMatrix3D;
        private var mvMatrix:Matrix3D;

        private var imageURL:String = "assets/130909wall_big.png";
        private var imgLoader:IMGLoader;
        private var urlRequest:URLRequest;
        private var image:HTMLImageElement;
        private var texture:Texture;

        private var vertices:Vector.<Number>;
        private var uvCoords:Vector.<Number>;
        private var indices:Vector.<Number>;

        private var ready:Boolean = false;

        public function PlaneTest(_index:int)
        {
            stage = new Stage(window.innerWidth, window.innerHeight);

            super(_index);



            urlRequest = new URLRequest(imageURL);
            imgLoader = new IMGLoader();
            imgLoader.addEventListener(Event.COMPLETE, imageCompleteHandler, this);
            imgLoader.load(urlRequest);
        }

        private function imageCompleteHandler(event:Event):void
        {
            image = imgLoader.image;
            stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContext3DCreateHandler, this);
            stage.stage3Ds[0].requestContext();
        }

        private function onContext3DCreateHandler(event:Stage3DEvent):void
        {
            stage.stage3Ds[0].removeEventListener(Event.CONTEXT3D_CREATE, onContext3DCreateHandler, this);

            stage3D = Stage3D(event.target);
            context3D = stage3D.context3D;

            texture = context3D.createTexture(512, 512, Context3DTextureFormat.BGRA, false);
            texture.uploadFromHTMLImageElement(image);

            context3D.configureBackBuffer(window.innerWidth, window.innerHeight, 0, true);
            context3D.setColorMask(true, true, true, true);


            vertices = new <Number>[-1.0,-1.0,0.0,
                1.0,-1.0,0.0,
                1.0,1.0,0.0,
                -1.0,1.0,0.0];


            uvCoords = new <Number>[0,0,
                1,0,
                1,1,
                0,1];

            indices = new <Number>[0,1,2,0,2,3];

            var vBuffer:VertexBuffer3D = context3D.createVertexBuffer(4, 3);
            Window.console.log(vBuffer);

            vBuffer.uploadFromArray(vertices, 0, 4);

            var tCoordBuffer:VertexBuffer3D = context3D.createVertexBuffer(4, 2);
            tCoordBuffer.uploadFromArray(uvCoords, 0, 4);

            iBuffer = context3D.createIndexBuffer(6);
            iBuffer.uploadFromArray(indices, 0, 6);

            program = context3D.createProgram();

            var vProgram:String = "uniform mat4 mvMatrix;\n" + "uniform mat4 pMatrix;\n" + "attribute vec2 aTextureCoord;\n" + "attribute vec3 aVertexPosition;\n" + "varying vec2 vTextureCoord;\n" + "void main() {\n" + "		gl_Position = pMatrix * mvMatrix * vec4(aVertexPosition, 1.0);\n" + "		vTextureCoord = aTextureCoord;\n" + "}\n";

            var fProgram:String = "varying mediump vec2 vTextureCoord;\n" + "uniform sampler2D uSampler;\n" + "void main() {\n" + "		gl_FragColor = texture2D(uSampler, vTextureCoord);\n" + "}\n";

            program.upload(vProgram, fProgram);
            context3D.setProgram(program);
            Window.console.log('-----------------------------------------------------------')

            pMatrix = new PerspectiveMatrix3D();
            pMatrix.perspectiveFieldOfViewLH(45, window.innerWidth / window.innerHeight, 0.1, 1000);

            mvMatrix = new Matrix3D(new <Number>[]);
            mvMatrix.appendTranslation(0, 0, 4);

            context3D.setGLSLVertexBufferAt("aVertexPosition", vBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
            context3D.setGLSLVertexBufferAt("aTextureCoord", tCoordBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);

            ready = true;
        }

        override protected function tick(dt:Number):void
        {
            if (ready){
                mvMatrix.appendRotation(dt * 0.1, new Vector3D(0, 1, 0));
                context3D.setProgram(program);
                context3D.setGLSLProgramConstantsFromMatrix("pMatrix", pMatrix, true);
                context3D.setGLSLProgramConstantsFromMatrix("mvMatrix", mvMatrix, true);

                context3D.setGLSLTextureAt("uSampler", this.texture, 0);

                context3D.clear(0.1, 0.2, 0.3, 1);
                context3D.drawTriangles(iBuffer, 0, 2);
                context3D.present();
            }
        }

        //override protected function resize():void
        //{
            /*if (context3D) {
                stage.resize(window.innerWidth, window.innerHeight);
                context3D.configureBackBuffer(window.innerWidth, window.innerHeight, 0, true);
                pMatrix.perspectiveFieldOfViewLH(45, window.innerWidth / window.innerHeight, 0.1, 1000);
            } */
        //}

        override public function Show():void
        {
            super.Show();
            if (stage3D) stage3D.canvas.style.setProperty('visibility', 'visible');
        }

        override public function Hide():void
        {
            super.Hide();
            if (stage3D) stage3D.canvas.style.setProperty('visibility', 'hidden');
        }
    }
}