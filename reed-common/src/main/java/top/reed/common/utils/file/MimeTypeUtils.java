package top.reed.common.utils.file;

/**
 * 媒体类型工具类
 *
 * @author reedsource
 */
public class MimeTypeUtils {
	public static final String IMAGE_PNG = "image/png";

	public static final String IMAGE_JPG = "image/jpg";

	public static final String IMAGE_JPEG = "image/jpeg";

	public static final String IMAGE_BMP = "image/bmp";

	public static final String IMAGE_GIF = "image/gif";

	public static final String[] IMAGE_EXTENSION = {"bmp", "gif", "jpg", "jpeg", "png"};

	public static final String[] FLASH_EXTENSION = {"swf", "flv"};

	public static final String[] MEDIA_EXTENSION = {"swf", "flv", "mp3", "wav", "wma", "wmv", "mid", "avi", "mpg",
			"asf", "rm", "rmvb"};

	public static final String[] TEXT_EXTENSION = {"doc", "docx", "xls", "xlsx", "ppt", "pptx", "html", "htm", "txt", "pdf", "ini", "java"};
	public static final String[] VIDEO_EXTENSION = {"mp4", "mpeg4", "3gp", "wav", "wma", "wmv"};
	public static final String[] AUDIO_EXTENSION = {"mp3", "mid", "wav", "wma", "avi"};
	public static final String[] ZIP_EXTENSION = {"rar", "zip", "gz", "bz2", "jar"};

	public static final String[] DEFAULT_ALLOWED_EXTENSION = {
			// 图片
			"bmp", "gif", "jpg", "jpeg", "png",
			// word excel powerpoint
			"doc", "docx", "xls", "xlsx", "ppt", "pptx", "html", "htm", "txt",
			// 压缩文件
			"rar", "zip", "gz", "bz2",
			// pdf
			"pdf"};
	/**
	 * 图片
	 */
	public static final String MATERIAL_TYPE_IMG = "1";
	/**
	 * 视频
	 */
	public static final String MATERIAL_TYPE_VIDEO = "2";
	/**
	 * 文本
	 */
	public static final String MATERIAL_TYPE_TEXT = "3";
	/**
	 * 音频
	 */
	public static final String MATERIAL_TYPE_AUDIO = "4";
	/**
	 * 压缩
	 */
	public static final String MATERIAL_TYPE_ZIP = "5";
	/**
	 * 其它
	 */
	public static final String MATERIAL_TYPE_OTHER = "6";

	public static String getExtension(String prefix) {
		return switch (prefix) {
			case IMAGE_PNG -> "png";
			case IMAGE_JPG -> "jpg";
			case IMAGE_JPEG -> "jpeg";
			case IMAGE_BMP -> "bmp";
			case IMAGE_GIF -> "gif";
			default -> "";
		};
	}
}
