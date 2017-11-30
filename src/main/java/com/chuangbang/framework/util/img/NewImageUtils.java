package com.chuangbang.framework.util.img;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.Toolkit;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.awt.image.ImageProducer;
import java.awt.image.RGBImageFilter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.StringUtils;

import com.chuangbang.framework.util.converter.CHexConver;

import sun.misc.BASE64Decoder;


public class NewImageUtils {


	/**
	 * 
	 * @Title: getFileImage
	 * @Description: 读取源文件 转换为java.awt.Image类型的数据
	 * @param file 源文件
	 * @return Image
	 */
	private static Image getFileImage(File file){
		Image image = null;
		if(Common.getFileExtension(file.getName()).equals("bmp")){
			FileInputStream in = null;
			try {
				in = new FileInputStream(file);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
			image = BMPLoader.read(in);
		}else{
			try {
				image = ImageIO.read(file);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return image;
	}

	/**
	 * 
	 * @Title: getMyBufferedImage
	 * @Description: 构建一个预定义图像类型的BufferedImage
	 * @param file 需要被叠加的图片文件
	 * @param scale 缩放等级 等于1 不进行缩放
	 * @return BufferedImage
	 */
	private static BufferedImage getMyBufferedImage(File file, float scale){

		Image image = getFileImage(file);// 得到Image对象
		BufferedImage buffImg = null;
		try {
			buffImg = javax.imageio.ImageIO.read(file);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//宽跟高
		int width = (image.getWidth(null));
		int height = (image.getHeight(null));
		// 构建一个预定义图像类型的BufferedImage
		buffImg = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
		// 创建Graphics2D对象，用在BufferedImage对象上绘图
		Graphics2D g2d = buffImg.createGraphics();
		// 设置图形上下文的当前颜色为透明色
		Color transparent = new Color(0, 0, 0, 0);
		g2d.setColor(transparent);
		// 填充指定的矩形区域
		g2d.fillRect(0, 0, width, height);
		
		g2d.drawImage(image, 0, 0, width, height, null);
		if(scale != 1.0f){
			//缩放图片
			BufferedImage filteredBufImage =new BufferedImage((int) (width*scale), (int) (height*scale),BufferedImage.TYPE_INT_RGB); //过滤后的图像
			AffineTransform transform = new AffineTransform(); //仿射变换对象
			transform.setToScale(scale, scale); //设置仿射变换的比例因子	
			AffineTransformOp imageOp = new AffineTransformOp(transform, null);//创建仿射变换操作对象			
			imageOp.filter(buffImg, filteredBufImage);//过滤图像，目标图像在filteredBufImage
			buffImg = filteredBufImage;
		}
		return buffImg;
	}

	/**
	 * 算法选择
	 * @return RenderingHints的一个对象
	 */
	private static RenderingHints getMyRenderingHints(){
		RenderingHints rh = new RenderingHints(RenderingHints.KEY_ANTIALIASING,// 抗锯齿提示键。
				RenderingHints.VALUE_ANTIALIAS_ON);// 抗锯齿提示值——使用抗锯齿模式完成呈现。
		rh.put(RenderingHints.KEY_TEXT_ANTIALIASING ,// 文本抗锯齿提示键。
				RenderingHints.VALUE_TEXT_ANTIALIAS_LCD_VRGB);//要求针对 LCD 显示器优化文本显示
		rh.put(RenderingHints.KEY_ALPHA_INTERPOLATION,// Alpha 插值提示值
				RenderingHints.VALUE_ALPHA_INTERPOLATION_QUALITY );// Alpha 插值提示值——选择偏重于精确度和视觉质量的 alpha 混合算法
		rh.put(RenderingHints.KEY_RENDERING,// 呈现提示键。
				RenderingHints.VALUE_RENDER_QUALITY);// 呈现提示值——选择偏重输出质量的呈现算法
		rh.put(RenderingHints.KEY_STROKE_CONTROL ,//笔划规范化控制提示键。
				RenderingHints.VALUE_STROKE_NORMALIZE);//几何形状应当规范化，以提高均匀性或直线间隔和整体美观。
		rh.put(RenderingHints.KEY_COLOR_RENDERING  ,//颜色呈现提示键。
				RenderingHints.VALUE_COLOR_RENDER_QUALITY );// 用最高的精确度和视觉质量执行颜色转换计算。
		return rh;
	}

	/**
	 * 
	 * @Title: printWatemark
	 * @Description: 添加水印
	 * @param g2d 由源文件生成的Graphics
	 * @param img 需要叠加的水印Image
	 * @param x 以右下角为原点 水印放置的X坐标
	 * @param y 以右下角为原点 水印放置的Y坐标
	 * @param width 水印图片的宽度
	 * @param height 水印图片的高度
	 * @param alpha 水印的透明度 选择值从0.0~1.0: 完全透明~完全不透明
	 * @return void
	 */
	private static void printWatemark(Graphics2D g2d,Image img,int x,int y,int width, int height,float alpha){
		//在图形和图像中实现混合和透明效果
		g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,
				alpha));
		Font font = new Font("SIM", Font.BOLD, 60);
		g2d.setFont(font);
		g2d.drawString("混合和透明效果", x, y-900);
		g2d.drawImage(img, x, y, width, height, null);
		
	}
	
	/**
	 * 
	 * @Title: printWatemark
	 * @Description: 添加水印
	 * @param g2d 由源文件生成的Graphics
	 * @param img 需要叠加的水印Image
	 * @param x 以右下角为原点 水印放置的X坐标
	 * @param y 以右下角为原点 水印放置的Y坐标
	 * @param width 水印图片的宽度
	 * @param height 水印图片的高度
	 * @param alpha 水印的透明度 选择值从0.0~1.0: 完全透明~完全不透明
	 * @param title 水印文字
	 * @return void
	 */
	private static void printWatemark(Graphics2D g2d,Image img,int x,int y,int width, int height,float alpha,String title,int twidth,int theight){
		//在图形和图像中实现混合和透明效果
		g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
		if(StringUtils.isNotBlank(title)){
			Font font = new Font("SIM", Font.BOLD, 50);
			Color c = new Color(0, 0, 0);
			g2d.setFont(font);
			g2d.setColor(c);
			g2d.drawString(title, twidth, theight);
		}
		g2d.drawImage(img, x, y, width, height, null);
		
	}
	
	/**
	 * 
	 * @Title: watermark
	 * @Description: 生成水印并返回java.awt.image.BufferedImage
	 * @param file 源文件(图片)
	 * @param waterFile 水印文件(图片)
	 * @param x 距离右下角的X偏移量
	 * @param y 距离右下角的Y偏移量
	 * @param alpha 透明度, 选择值从0.0~1.0: 完全透明~完全不透明
	 * @param title 图片文字
	 * @param twidth 文字坐标
	 * @param theight 文字坐标 
	 * @return
	 */
	public static BufferedImage watermark(File file, File waterFile,int x,int y, float alpha,String title,int twidth,int theight) {
		BufferedImage buffImg = getMyBufferedImage(file, 1.0f);
		BufferedImage waterImg = null;
		try {
			waterImg = javax.imageio.ImageIO.read(waterFile);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 创建Graphics2D对象，用在BufferedImage对象上绘图
		Graphics2D g2d = buffImg.createGraphics();
		g2d.setRenderingHints(getMyRenderingHints());
		
		int sourceImgWidth  = buffImg.getWidth();
		int sourceImgHeight = buffImg.getHeight();

		int waterImgWidth = waterImg.getWidth();
		int waterImgHeight = waterImg .getHeight();
		
		int tWidth = sourceImgWidth-waterImgWidth-twidth;
		int tHeight = theight;


		printWatemark(g2d,waterImg,sourceImgWidth-waterImgWidth-x,sourceImgHeight-waterImgHeight-y,waterImgWidth,waterImgHeight,alpha,title,tWidth,tHeight);
		g2d.dispose();// 释放图形上下文使用的系统资源
		return buffImg;
	}


	/**
	 * 
	 * @Title: watermark
	 * @Description: 生成水印并返回java.awt.image.BufferedImage
	 * @param file 源文件(图片)
	 * @param waterFile 水印文件(图片)
	 * @param x 距离右下角的X偏移量
	 * @param y 距离右下角的Y偏移量
	 * @param alpha 透明度, 选择值从0.0~1.0: 完全透明~完全不透明
	 * @return BufferedImage
	 */
	public static BufferedImage watermark(File file, File waterFile,int x,int y, float alpha) {
		BufferedImage buffImg = getMyBufferedImage(file, 1.0f);
		BufferedImage waterImg = null;
		waterImg = getMyBufferedImage(waterFile, 0.55f);
		// 创建Graphics2D对象，用在BufferedImage对象上绘图
		Graphics2D g2d = buffImg.createGraphics();
		g2d.setRenderingHints(getMyRenderingHints());
		
		int sourceImgWidth  = buffImg.getWidth();
		int sourceImgHeight = buffImg.getHeight();

		int waterImgWidth = waterImg.getWidth();
		int waterImgHeight = waterImg .getHeight();


		printWatemark(g2d,waterImg,sourceImgWidth-waterImgWidth-x,sourceImgHeight-waterImgHeight-y,waterImgWidth,waterImgHeight,alpha);
		g2d.dispose();// 释放图形上下文使用的系统资源
		return buffImg;
	}

	/**
	 * 输出水印图片
	 * @param buffImg 图像加水印之后的BufferedImage对象
	 * @param savePath 图像加水印之后的保存路径
	 */
	public static void generateWaterFile(BufferedImage buffImg, String savePath) {
		int temp = savePath.lastIndexOf(".") + 1;
		try {
			int tem = savePath.lastIndexOf("/") + 1;
			String dir = savePath.substring(0,tem);
			System.out.println(">>>>>>>>>>"+dir);
			File file = new File(dir);
			if (!file.exists()) { // 如果文件所在的目录不存在，则创建目录
				file.mkdirs();
			}
			ImageIO.write(buffImg, savePath.substring(temp), new File(savePath));
		} catch (IOException e1) {
			e1.printStackTrace();
		}
	}

	public static boolean GenerateImage(String imgStr, File imgFile) {// 对字节数组字符串进行Base64解码并生成图片  
		if (imgStr == null) // 图像数据为空  
			return false;  
		BASE64Decoder decoder = new BASE64Decoder();  
		try {  
			// Base64解码  
			byte[] bytes = decoder.decodeBuffer(imgStr);  
			for (int i = 0; i < bytes.length; ++i) {  
				if (bytes[i] < 0) {// 调整异常数据  
					bytes[i] += 256;  
				}  
			}  
			// 生成jpeg图片  
			OutputStream out = new FileOutputStream(imgFile);  
			out.write(bytes);  
			out.flush();  
			out.close();  
			return true;  
		} catch (Exception e) {  
			e.printStackTrace();
			return false;  
		}  
	}  
	public static boolean GenerateIOSImage(String imgDate, File imgFile) {// 对字节数组字符串进行Base64解码并生成图片  
		imgDate = imgDate.replace("<", "").replace(">", "");
		String data[]=imgDate.split(" "); 
		FileOutputStream fos;  
		try {  
		    fos = new FileOutputStream(imgFile);  
		    for(String hexStr : data){  
		        byte[] bytes =CHexConver.hexStr2Bytes(hexStr);  
		        fos.write(bytes, 0, bytes.length);    
		    }  
		    fos.flush();  
		    fos.close();  
		} catch (IOException e) {  
		    e.printStackTrace();  
		    return false;
		} finally{  
			
		}  
		return true;
	}
	
	public static boolean GenerateIOSPDF(String imgDate, File imgFile) {// 对字节数组字符串进行Base64解码并生成图片  
		imgDate = imgDate.replace("<", "").replace(">", "");
		String data[]=imgDate.split(" "); 
		FileOutputStream fos;  
		try {  
		    fos = new FileOutputStream(imgFile);  
		    for(String hexStr : data){  
		        byte[] bytes =CHexConver.hexStr2Bytes(hexStr);  
		        fos.write(bytes, 0, bytes.length);    
		    }  
		    fos.flush();  
		    fos.close();  
		} catch (IOException e) {  
		    e.printStackTrace();  
		    return false;
		} finally{  
			
		}  
		return true;
	}
	
	/** 
     * 缩放图像 
     * @param srcImageFile 源图像文件地址 
     * @param result       缩放后的图像地址 
     * @param scale        缩放比例 
     * @param flag         缩放选择:true 放大; false 缩小; 
     */  
    public static void scale(String srcImageFile, String result, int scale, boolean flag){  
        try{  
            BufferedImage src = ImageIO.read(new File(srcImageFile)); // 读入文件  
            int width = src.getWidth(); // 得到源图宽  
            int height = src.getHeight(); // 得到源图长  
            if (flag) {  
                // 放大  
                width = width * scale;  
                height = height * scale;  
            }else {  
                // 缩小  
                width = width / scale;  
                height = height / scale;  
            }  
            Image image = src.getScaledInstance(width, height, Image.SCALE_DEFAULT);  
            BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);  
            Graphics g = tag.getGraphics();  
            g.drawImage(image, 0, 0, null); // 绘制缩小后的图  
            g.dispose();  
            ImageIO.write(tag, "JPEG", new File(result));// 输出到文件流  
        }  
        catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
    
    /** 
     * 
     * @param filesrc 
     * @param logosrc 
     * @param outsrc 
     * @param x 位置 
     * @param y 位置 
     */  
  public static void composePic(String filesrc,String logosrc,String outsrc,int x,int y) {  
    try {  
        File bgfile = new File(filesrc);  
        Image bg_src = javax.imageio.ImageIO.read(bgfile);  
         
        File logofile = new File(logosrc);  
        Image logo_src = javax.imageio.ImageIO.read(logofile);  
         
        int bg_width = bg_src.getWidth(null);  
        int bg_height = bg_src.getHeight(null);  
        int logo_width = logo_src.getWidth(null);;  
        int logo_height = logo_src.getHeight(null);  
  
        BufferedImage tag = new BufferedImage(bg_width, bg_height, BufferedImage.TYPE_INT_RGB);  
         
        Graphics2D g2d = tag.createGraphics();  
        g2d.drawImage(bg_src, 0, 0, bg_width, bg_height, null);  
         
        g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP,0.0f)); //透明度设置开始   
        g2d.drawImage(logo_src,x,y,logo_width,logo_height, null);             
        g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER)); //透明度设置 结束  
         
        FileOutputStream out = new FileOutputStream(outsrc);  
        com.sun.image.codec.jpeg.JPEGImageEncoder encoder = com.sun.image.codec.jpeg.JPEGCodec.createJPEGEncoder(out);  
        encoder.encode(tag);  
        out.close();  
    }catch (Exception e) {  
        e.printStackTrace();  
    }  
  }  
  public static Image makeColorTransparent(Image im, final Color color) {
      ImageFilter filter = new RGBImageFilter() {
          // the color we are looking for... Alpha bits are set to opaque
          public int markerRGB = color.getRGB() | 0xFF000000;

          @Override
          public final int filterRGB(int x, int y, int rgb) {
              if ((rgb | 0xFF000000) == markerRGB) {
                  // Mark the alpha bits as zero - transparent
                  return 0x00FFFFFF & rgb;
              } else {
                  // nothing to do
                  return rgb;
              }
          }
      };

      ImageProducer ip = new FilteredImageSource(im.getSource(), filter);
      return Toolkit.getDefaultToolkit().createImage(ip);
  }
  
  
  public static String AddwaterMark(String sourceFilePath, String waterFilePath){
	  BufferedImage buffImg = watermark(new File(sourceFilePath), new File(waterFilePath),0,0, 1.0f,"",0,0);
	  // 输出水印图片
	  generateWaterFile(buffImg, sourceFilePath);
	  return sourceFilePath;
  }
  
  
  
  
  
	public static void main(String[] args) throws IOException {
//		String sourceFilePath = "D:\\dgdoc\\worksp_newasj\\weixin_mysql\\src\\main\\webapp\\UpFiles/wshop/template/mingpianbg.jpg";
//		String waterFilePath = "D:\\dgdoc\\worksp_newasj\\weixin_mysql\\src\\main\\webapp\\UpFiles/wshop/qrcode/402881e44fb0c8ba014fb0d2b6d50000/QR_LIMIT_STR_SCENE_SELF-252650125_1442563965241.jpg";
		String sourceFilePath = "L:/1E3A3092-HDR.png";
		String waterFilePath = "L:/watermark.png";
//		System.out.println(sourceFilePath);
//		System.out.println(waterFilePath);
		NewImageUtils newImageUtils = new NewImageUtils();
		// 对图像加水印
		BufferedImage buffImg = NewImageUtils.watermark(new File(sourceFilePath), new File(waterFilePath),0,0, 1.0f,"",0,0);
		// 输出水印图片
		NewImageUtils.generateWaterFile(buffImg, sourceFilePath);
	}
	
}
