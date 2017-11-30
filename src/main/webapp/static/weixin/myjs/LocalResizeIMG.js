    /**
     * 获得base64
     * @param {Object} obj
     * @param {Number} [obj.width] 图片需要压缩的宽度，高度会跟随调整
     * @param {Number} [obj.quality=0.8] 压缩质量，不压缩为1
     * @param {Function} [obj.before(this, blob, file)] 处理前函数,this指向的是input:file
     * @param {Function} obj.success(obj) 处理后函数
     * @example
     *
     */
    $.fn.localResizeIMG = function(obj) {
        this.on('change', function() {
            var file = this.files[0];
            var URL = window.URL || window.webkitURL;
            var blob = URL.createObjectURL(file);

            // 执行前函数
            if ($.isFunction(obj.before)) {
                obj.before(this, blob, file)
            };

            _create(blob, file);
            this.value = ''; // 清空临时数据
        });

        /**
         * 生成base64
         * @param blob 通过file获得的二进制
         */
        function _create(blob,file) {
            var img = new Image();
            img.src = blob;

            img.onload = function() {
                var that = this;

                //生成比例
                var w = that.width,
                    h = that.height,
                    scale = w / h;
                w = obj.width || w;
                h = w / scale;

                //生成canvas
                var canvas = document.createElement('canvas');
                var ctx = canvas.getContext('2d');
                $(canvas).attr({
                    width: w,
                    height: h
                });
                ctx.drawImage(that, 0, 0, w, h);
               // 

                /**
                 * 生成base64
                 * 兼容修复移动设备需要引入mobileBUGFix.js
                 */
                var base64 = canvas.toDataURL('image/jpeg', obj.quality || 0.8);

                // 修复IOS
                if (navigator.userAgent.match(/iphone/i)) {
                	  
                      // 生成结果
                      /*var result = {
                          base64: base64,
                          clearBase64: base64.substr(base64.indexOf(',') + 1)
                      };
                      // 执行后函数
                      obj.success(result);*/
                      
                     //获取照片方向角属性，用户旋转控制  
                     EXIF.getData(file, function() {  
                       // alert(EXIF.pretty(this));  
                        EXIF.getAllTags(this);   
                        //alert(EXIF.getTag(this, 'Orientation'));   
                        var img_orientation = EXIF.getTag(this, 'Orientation');  
                        //return;  
                        
                      //如果方向角不为1，都需要进行旋转 added by lzk  
                      if(img_orientation){  
                            switch(img_orientation){  
                                case 6://需要顺时针（向左）90度旋转  
                                    rotateImg(that,'left',canvas,ctx,w,h);  
                                    break;  
                                case 8://需要逆时针（向右）90度旋转  
                                    rotateImg(that,'right',canvas,ctx,w,h);   
                                    break;  
                                case 3://需要180度旋转  
                                    rotateImg(that,'right',canvas,ctx,w,h);  //转两次  
                                    rotateImg(that,'right',canvas,ctx,w,h);    
                                    break;  
                            }         
                      }  
                      
                      base64 = canvas.toDataURL('image/jpeg', obj.quality || 0.8);
                      var result = {
                          base64: base64,
                          clearBase64: base64.substr(base64.indexOf(',') + 1)
                      };
                      // 执行后函数
                      obj.success(result);
                      
                        
                    });  
                    
                }else   {	//ios
	                // 修复android
	                if (navigator.userAgent.match(/Android/i)) {
	                    var encoder = new JPEGEncoder();
	                    base64 = encoder.encode(ctx.getImageData(0, 0, w, h), obj.quality * 100 || 80);
	                }
	                // 生成结果
                    var result = {
                        base64: base64,
                        clearBase64: base64.substr(base64.indexOf(',') + 1)
                    };

                    // 执行后函数
                    obj.success(result);
                }
            };
        }
    };


    // 例子
    /*
    $('input:file').localResizeIMG({
        width: 100,
        quality: 0.1,
        //before: function (that, blob) {},
        success: function (result) {
            var img = new Image();
            img.src = result.base64;

            $('body').append(img);
            console.log(result);
        }
    });
*/
    
    
  //对图片旋转处理 added by lzk  
    function rotateImg(img, direction,canvas,ctx,w,h) {    
            //alert(img); 
            //最小与最大旋转方向，图片旋转4次后回到原方向    
            var min_step = 0;    
            var max_step = 3;    
            //var img = document.getElementById(pid);    
            if (img == null)return;    
            //img的高度和宽度不能在img元素隐藏后获取，否则会出错    
            var width = w;    
            var height = h;    
            //var step = img.getAttribute('step');    
            var step = 2;    
            if (step == null) {    
                step = min_step;    
            }    
            if (direction == 'right') {    
                step++;    
                //旋转到原位置，即超过最大值    
                step > max_step && (step = min_step);    
            } else {    
                step--;    
                step < min_step && (step = max_step);    
            }    
           // var ctx = canvas.getContext('2d');    
            //img.setAttribute('step', step);    
            /*var canvas = document.getElementById('pic_' + pid);   
            if (canvas == null) {   
                img.style.display = 'none';   
                canvas = document.createElement('canvas');   
                canvas.setAttribute('id', 'pic_' + pid);   
                img.parentNode.appendChild(canvas);   
            }  */  
            //旋转角度以弧度值为参数    
            var degree = step * 90 * Math.PI / 180;    
            switch (step) {    
                case 0:    
                    canvas.width = width;    
                    canvas.height = height;    
                   ctx.drawImage(img, 0, 0, w, h);    
                    break;    
                case 1:    
                    canvas.width = height;    
                    canvas.height = width;    
                    ctx.rotate(degree);    
                   ctx.drawImage(img, 0, -height, w, h);  
                    break;    
                case 2:    
                    canvas.width = width;    
                    canvas.height = height;    
                    ctx.rotate(degree);    
                    ctx.drawImage(img, -width, -height, w, h); 
                    break;    
                case 3:    
                    canvas.width = height;    
                    canvas.height = width;    
                    ctx.rotate(degree);    
                   ctx.drawImage(img, -width, 0, w, h);   
                    break;    
            }    
        } 
