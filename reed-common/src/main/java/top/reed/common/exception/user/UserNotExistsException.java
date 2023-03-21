package top.reed.common.exception.user;

import java.io.Serial;

/**
 * 用户不存在异常类
 *
 * @author reedsource
 */
public class UserNotExistsException extends UserException {
    @Serial
    private static final long serialVersionUID = 1L;

    public UserNotExistsException() {
        super("user.not.exists", null);
    }
}
