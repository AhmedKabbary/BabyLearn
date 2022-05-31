<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Draw.aspx.cs" Inherits="BabyLearn.Draw" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Drawing</title>

    <style>
        #sketchpad {
            border-radius: 5px;
        }

        img.hint {
            opacity: 0.5;
        }

            img.hint::selection {
                background: none;
                color: inherit;
            }

        #sketchpad.draw {
            border: 1px solid black;
            cursor: pointer;
        }

        #sketchpad.erase {
            border: 1px solid red;
            cursor: grab;
        }

        .color_container {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            border: none;
        }

            .color_container:hover {
                cursor: pointer;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="w-100 bg-light d-flex justify-content-center align-items-center">
        <div class="container">

            <div class="row">
                <div class="col-12 col-md-6 align-self-center mb-5">
                    <div class="row justify-content-around mt-4 mb-4">
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(0, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(30, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(60, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(120, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(180, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(215, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(270, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(330, 100%, 50%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(30, 100%, 30%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                        <div class="col-1 d-flex justify-content-center">
                            <div>
                                <div class="color_container" style="background-color: hsl(0, 0%, 0%);"
                                    onclick="setColor(this)">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4 mb-4">
                        <div class="col d-flex justify-content-center">
                            <div>
                                <label for="penWidth">Pen width</label>
                                <br />
                                <input id="penWidth" type="range" name="penWidth" min="1" max="50">
                            </div>
                        </div>

                        <div class="col d-flex justify-content-center">
                            <div>
                                <label for="eraserRadius">Eraser radius</label>
                                <br />
                                <input id="eraserRadius" type="range" name="eraserRadius" min="1" max="50">
                            </div>
                        </div>
                    </div>

                    <div class="row mt-4 mb-4">
                        <div class="col d-flex justify-content-center">
                            <div class="btn btn-outline-primary" onclick="onReset()">Reset</div>
                        </div>
                        <div class="col d-flex justify-content-center">
                            <div class="btn btn-outline-primary" onclick="onEraser(this)">Eraser</div>
                        </div>
                        <div class="col d-flex justify-content-center">
                            <div class="btn btn-primary" onclick="onSave()">Save</div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-6 align-self-center">
                    <div class="d-flex justify-content-center">
                        <div style="z-index: 10;">
                            <asp:Image ID="Image1" runat="server" CssClass="hint" Style="width: 299px; height: 299px; z-index: -10; position: absolute; object-fit: contain;" />
                            <canvas id="sketchpad" class="draw" width="300" height="300"></canvas>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <script>
        //
        let canvas = document.getElementById('sketchpad');

        let penWidthInput = document.getElementById('penWidth');
        let eraserRadiusInput = document.getElementById('eraserRadius');
        //

        let context = canvas.getContext('2d');

        context.lineWidth = 2.5;
        penWidthInput.value = context.lineWidth;
        let eraserRadius = 25;
        eraserRadiusInput.value = eraserRadius;

        let isIdle = true;
        let isEraser = false;

        function drawStart(event) {
            context.beginPath();
            let x = event.pageX - canvas.offsetLeft;
            let y = event.pageY - canvas.offsetTop;
            context.lineTo(x, y);
            isIdle = false;
        }

        function drawEnd(event) {
            if (isIdle) return;
            drawMove(event);
            isIdle = true;
        }

        function drawMove(event) {
            if (isIdle) return;
            if (isEraser) return eraseMove(event);
            let x = event.pageX - canvas.offsetLeft;
            let y = event.pageY - canvas.offsetTop;
            context.lineTo(x, y);
            context.stroke();
        }

        function eraseMove(event) {
            let x = event.pageX - canvas.offsetLeft;
            let y = event.pageY - canvas.offsetTop;

            context.save();
            context.arc(x, y, eraserRadius, 0, 2 * Math.PI, true);
            context.clip();
            context.clearRect(x - eraserRadius, y - eraserRadius, eraserRadius * 2, eraserRadius * 2);
            context.restore();
        }

        //

        function touchStart(event) { drawStart(event.touches[0]) }
        function touchMove(event) { drawMove(event.touches[0]); event.preventDefault(); }
        function touchEnd(event) { drawEnd(event.changedTouches[0]) }

        //

        canvas.addEventListener('touchstart', touchStart);
        canvas.addEventListener('touchmove', touchMove);
        canvas.addEventListener('touchend', touchEnd);

        canvas.addEventListener('mousedown', drawStart);
        canvas.addEventListener('mousemove', drawMove);
        canvas.addEventListener('mouseup', drawEnd);

        //

        let onReset = function () {
            context.lineWidth = 2.5;
            penWidthInput.value = context.lineWidth;
            eraserRadius = 25;
            eraserRadiusInput.value = eraserRadius;

            context.strokeStyle = 'black';

            context.clearRect(0, 0, canvas.width, canvas.height);
        };

        let onEraser = function (element) {
            isEraser = !isEraser;
            if (isEraser) {
                canvas.className = "erase";
                element.innerHTML = "Pen";
            } else {
                canvas.className = "draw";
                element.innerHTML = "Eraser";
            }
        };

        let onSave = function () {
            let downloadLink = document.createElement('a');
            downloadLink.setAttribute('download', 'CanvasAsImage.png');
            let dataURL = canvas.toDataURL('image/png');
            let url = dataURL.replace(/^data:image\/png/, 'data:application/octet-stream');
            downloadLink.setAttribute('href', url);
            downloadLink.click();
        };

        let setColor = function (element) {
            context.strokeStyle = window.getComputedStyle(element, null).getPropertyValue('background-color');
        };

        penWidthInput.addEventListener('change', function () {
            context.lineWidth = penWidthInput.value;
        });

        eraserRadiusInput.addEventListener('change', function () {
            eraserRadius = eraserRadiusInput.value;
        });
    </script>

</asp:Content>
