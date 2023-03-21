package top.reed.common.exception.user;

import java.io.Serial;

/**
 * 用户锁定异常类
 *
 * @author reedsource
 */
public class UserBlockedException extends UserException {
    @Serial
    private static final long serialVersionUID = 1L;

    public UserBlockedException() {
        super("user.blocked", null);
    }
}
