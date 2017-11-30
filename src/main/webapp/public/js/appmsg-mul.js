$(function() {
    $("#file_upload").omFileUpload({
        action: "/upload/resource/image",
        fileExt: "*.jpg;*.png;*.gif;*.jpeg;*.bmp",
        buttonImg: window.www_res_domain + "/image/upload/upload_btn.png",
        fileDesc: "Image Files",
        sizeLimit: sizeLimit,
        onError: function(ID, fileObj, errorObj, event) {
            if (errorObj.type == "File Size") {
                alert("上传图片的大小不能超过500KB")
            }
        },
        onSelect: function(ID, fileObj, event) {
            setTimeout(function() {
                $("#file_upload").omFileUpload({
                    actionData: {
                        uid: $("#uid").val()
                    }
                });
                $("#file_upload").omFileUpload("upload")
            },
            10)
        },
        swf: "../../swf/om-fileupload.swf",
        method: "GET",
        onComplete: function(ID, fileObj, response, data, event) {
            var jsonData = eval("(" + response + ")");
            if (jsonData.error == "filetype") {
                alert("文件上传格式只能支持：" + jsonData.allowtype);
                return false
            }
            $(".default-tip", window.appmsg).hide();
            $(".i-img", window.appmsg).attr("src", jsonData.fileUrl).show();
            $("#imgArea").show().find(" #img").attr("src", jsonData.fileUrl);
            $(".cover", window.appmsg).val(jsonData.fileName);
            $(".coverurl", window.appmsg).val(jsonData.fileUrl);
            $.post("/admin/resource/image", {
                action: "create",
                wuid: window.wuid,
                fileUrl: jsonData.fileName,
                fileName: fileObj.name
            },
            function(data) {
                if (data.success == true) {
                    $(".coverUniqueId", window.appmsg).val(data.coverUniqueId)
                }
            },
            "json")
        }
    });
    $(".msg-editer #title").bind("keyup",
    function() {
        $(".i-title", window.appmsg).text($(this).val());
        $(".title", window.appmsg).val($(this).val())
    });
    $(".msg-editer #source_url").bind("keyup",
    function() {
        $(".sourceurl", window.appmsg).val($(this).val())
    });
    $(".msg-editer #show_cover_pic").bind("click",
    function() {
        $(".show_cover_pic", window.appmsg).val($(this).is(":checked") ? 1 : 0)
    });
    $(".msg-editer #chain").bind("keyup",
    function() {
        $(".chain", window.appmsg).val($(this).val())
    });
    $("#url-block-link").click(function() {
        $("#url-block").show();
        $(this).hide()
    });
    $("#chain-block-link").click(function() {
        $("#chain-block").show();
        $(this).hide()
    });
    $("#delImg").click(function() {
        $(".default-tip", window.appmsg).show();
        $("#imgArea").hide();
        $(".cover,.coverurl,coverUniqueId", window.appmsg).val("");
        $(".i-img", window.appmsg).hide()
    });
    $("#cancel-btn").click(function(event) {
        event.stopPropagation();
        location.href = "/admin/resource/article_list.jsp?1&wuid=" + window.wuid;
        return
    });
    $("#appmsgItem1,.sub-msg-item").live({
        mouseover: function() {
            $(this).addClass("sub-msg-opr-show")
        },
        mouseout: function() {
            $(this).removeClass("sub-msg-opr-show")
        }
    });
    $(".sub-add-btn").click(function() {
        var len = $(".sub-msg-item").size();
        if (len >= 7) {
            alert("最多只能加入8条图文信息");
            return
        }
        var $lastItem = $(".sub-msg-item:last");
        var $newItem = $lastItem.clone();
        $("input,textarea", $newItem).val("");
        $(".i-title", $newItem).text("");
        $(".default-tip", $newItem).css("display", "block");
        $(".cover,.coverurl,.coverUniqueId", $newItem).val("");
        $(".i-img", $newItem).hide();
        $(".show_cover_pic", $newItem).val("1");
        $(".modetype", $newItem).val("1");
        $(".rid", $newItem).remove();
        $lastItem.after($newItem)
    });
    $(".sub-msg-opr .edit-icon").live("click",
    function() {
        window.appmsg.find(".content").val(window.msg_editor.getContent());
        var $msgItem = $(this).closest(".appmsgItem");
        var index = $(".appmsgItem").index($msgItem);
        window.appmsgIndex = index;
        window.appmsg = $msgItem;
        $("#title").val($(".title", $msgItem).val());
        if ($(".coverurl", $msgItem).val() == "") {
            $("#imgArea").hide()
        } else {
            $("#imgArea").show().find("#img").attr("src", $(".coverurl", $msgItem).val())
        }
        if ($(".show_cover_pic", $msgItem).val() == 0) {
            $("#show_cover_pic").attr("checked", false)
        } else {
            $("#show_cover_pic").attr("checked", true)
        }
        if ($(".sourceurl", $msgItem).val() == "") {
            $("#url-block-link").show();
            $("#url-block").hide().find("#source_url").val("")
        } else {
            $("#url-block-link").hide();
            $("#url-block").show().find("#source_url").val($(".sourceurl", $msgItem).val())
        }
        $(".mode").val(1);
        $("#article_content").show();
        $("#link_content").hide();
        $("#link_content #chain").val("");
        window.msg_editor.setContent($(".content", $msgItem).val());
        computeChar();
        if (index == 0) {
            $(".msg-editer-wrapper").css("margin-top", "0px")
        } else {
            var top = 110 + $(".sub-msg-item").eq(0).outerHeight(true) * index;
            $(".msg-editer-wrapper").css("margin-top", top + "px")
        }
    });
    
    
    $(".sub-msg-opr .edit_btn").on("click",
    	    function() {
    	        window.appmsg.find(".content").val(window.msg_editor.getContent());
    	        var $msgItem = $(this).closest(".appmsgItem");
    	        var index = $(".appmsgItem").index($msgItem);
    	        window.appmsgIndex = index;
    	        window.appmsg = $msgItem;
    	        $("#title").val($(".title", $msgItem).val());
    	        if ($(".coverurl", $msgItem).val() == "") {
    	            $("#imgArea").hide()
    	        } else {
    	            $("#imgArea").show().find("#img").attr("src", $(".coverurl", $msgItem).val())
    	        }
    	        if ($(".show_cover_pic", $msgItem).val() == 0) {
    	            $("#show_cover_pic").attr("checked", false)
    	        } else {
    	            $("#show_cover_pic").attr("checked", true)
    	        }
    	        if ($(".sourceurl", $msgItem).val() == "") {
    	            $("#url-block-link").show();
    	            $("#url-block").hide().find("#source_url").val("")
    	        } else {
    	            $("#url-block-link").hide();
    	            $("#url-block").show().find("#source_url").val($(".sourceurl", $msgItem).val())
    	        }
    	        $(".mode").val(1);
    	        $("#article_content").show();
    	        $("#link_content").hide();
    	        $("#link_content #chain").val("");
    	        window.msg_editor.setContent($(".content", $msgItem).val());
    	        computeChar();
    	        if (index == 0) {
    	            $(".msg-editer-wrapper").css("margin-top", "0px")
    	        } else {
    	            var top = 110 + $(".sub-msg-item").eq(0).outerHeight(true) * index;
    	            $(".msg-editer-wrapper").css("margin-top", top + "px")
    	        }
    	    });
    $(".sub-msg-opr .del-icon").live("click",
    function() {
        var len = $(".appmsgItem").size();
        if (len <= 2) {
            alert("无法删除，多条图文至少需要2条消息。");
            return
        }
        if (confirm("确认删除此消息？")) {
            var $msgItem = $(this).closest(".sub-msg-item");
            if ($(".rid", $msgItem).size() > 0) {
                window.delResId.push($(".rid", $msgItem).val())
            }
            $msgItem.remove()
        }
    });
    window.appmsgIndex = 0;
    window.appmsg = $("#appmsgItem1");
    window.delResId = [];
    window.msg_editor = new UE.ui.Editor({
        initialFrameWidth: 498
    });
    window.msg_editor.render("editor");
    window.msg_editor.addListener("ready",
    function(editor) {
        setTimeout(function() {
            var html = '<div id="eduitel" class="edui-box edui-button edui-default"><div id="eduitel_state" onclick="telClick()" onmousedown="mousedown(this)" onmouseup="mouseup(this)" onmouseover="mouseon(this)" onmouseout="mouseout(this)" class="edui-default"><div class="edui-button-wrap edui-default"><div id="eduitel_body" unselectable="on" title="电话号码" class="edui-button-body edui-default" onmousedown="return false;"><div class="edui-box edui-icon edui-default"></div><div class="edui-box edui-label edui-default"></div></div></div></div></div>';
            $(".edui-default .edui-toolbar").append(html)
        },
        1)
    });
    function computeChar() {
        var len = msg_editor.getContent().length;
        if (len > charLimit) {
            $(".editor-bottom-bar").html("<span style='color:red;'>你输入的字符个数（" + len + "）已经超出最大允许值！</span>")
        } else {
            $(".editor-bottom-bar").html("当前已输入<span class='char_count'>" + len + "</span>个字符, 您还可以输入<span class='char_remain'>" + (charLimit - len) + "</span>个字符。")
        }
    }
    window.msg_editor.addListener("keyup",
    function(type, evt) {
        computeChar()
    });
    $("#closeadbang").click(function() {
        $("#addBangeCover, #adBang").fadeOut();
        if ($("#nolongerbange").prop("checked")) {
            $.cookie("nolongershowad", "1", {
                expires: 60,
                path: "/"
            })
        }
        location.href = "/admin/resource/article_list.jsp?1&wuid=" + window.wuid
    });
    $("#save-btn").click(function() {
        var $btn = $(this);
        if ($btn.hasClass("disabled")) {
            return
        }
        window.appmsg.find(".content").val(window.msg_editor.getContent());
        var valid = true;
        var $msgItem;
        var jsonData = [];
        $(".appmsgItem").each(function(index, msgItem) {
            $msgItem = $(msgItem);
            var title = $("input.title", $msgItem).val();
            var cover = $("input.cover", $msgItem).val();
            var coverUniqueId = $("input.coverUniqueId", $msgItem).val();
            var show_cover_pic = $("input.show_cover_pic", $msgItem).val();
            if (show_cover_pic == null) {
                show_cover_pic = 1
            }
            var content = $("textarea.content", $msgItem).val();
            var sourceurl = $("input.sourceurl", $msgItem).val();
            var chain = $("input.chain", $msgItem).val();
            var modetype = $("input.modetype", $msgItem).val();
            if (modetype == 1) {
                chain = ""
            }
            if (title == "") {
                alert("标题不能为空");
                valid = false;
                return false
            }
            if (cover == "") {
                alert("必须上传一个封面图片");
                valid = false;
                return false
            }
            if (content == "") {
                alert("图文模式下正文内容不可以为空。");
                valid = false;
                return false
            }
            jsonData[index] = {
                title: title,
                cover: cover,
                coverUniqueId: coverUniqueId,
                content: content,
                show_cover_pic: show_cover_pic,
                sourceurl: sourceurl,
                chain: chain
            };
            if ($(".rid", $msgItem).size() > 0) {
                jsonData[index].rid = $(".rid", $msgItem).val()
            }
        });
        if (!valid) {
            $(".edit-icon", $msgItem).click();
            return false
        }
        var sumbitData = {
            jsonData: $.toJSON(jsonData),
            wuid: window.wuid,
            action: $("#action").val()
        };
        if (window.delResId.length > 0) {
            sumbitData.delResId = $.toJSON(window.delResId)
        }
        $btn.addClass("disabled");
        $.post("/admin/resource/article", sumbitData,
        function(data) {
            $btn.removeClass("disabled");
            if (data.success == true) {
                alert("保存成功");
                location.href = "/admin/resource/article_list.jsp?1&wuid=" + window.wuid
            } else {
                if ("1" == data.errorCode) {
                    alert("图文条数已经达到上限了!")
                } else {
                    alert(data.errorMsg)
                }
            }
        },
        "json")
    });
    var sourceTemplate = new SourceTemplate(window.msg_editor);
    sourceTemplate.wrap().init();
    var copy_editor_html = $("#copy-editor-html");
    var clear_editor = $("#clear-editor");
    var preview_editor = $("#preview-editor");
    function copy_code(copyText) {
        if (window.clipboardData) {
            window.clipboardData.setData("Text", copyText)
        } else {
            var flashcopier = "flashcopier";
            if (!document.getElementById(flashcopier)) {
                var divholder = document.createElement("div");
                divholder.id = flashcopier;
                document.body.appendChild(divholder)
            }
            document.getElementById(flashcopier).innerHTML = "";
            var divinfo = '<embed src="../js/_clipboard.swf" FlashVars="clipboard=' + encodeURIComponent(copyText) + '" width="0" height="0" type="application/x-shockwave-flash"></embed>';
            document.getElementById(flashcopier).innerHTML = divinfo
        }
        alert("copy成功！")
    }
});
function mouseon(a) {
    $(a).addClass("edui-state-hover")
}
function mouseout(a) {
    $(a).removeClass("edui-state-hover").removeClass("edui-state-active")
}
function mousedown(a) {
    $(a).addClass("edui-state-active")
}
function mouseup(a) {
    $(a).removeClass("edui-state-active")
}
function telClick() {
    var a = window.prompt("请输入您的电话号码", "");
    if (!a) {
        return
    }
    window.msg_editor.execCommand("insertHtml", '<span style="color:blue;">[tel]' + a + "[/tel]</span>")
};