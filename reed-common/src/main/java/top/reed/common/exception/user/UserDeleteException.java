package top.reed.common.exception.user;

import java.io.Serial;

/**
 * 用户账号已被删除
 *
 * @author reedsource
 */
public class UserDeleteException extends UserException {
    @Serial
    private static final long serialVersionUID = 1L;

    public UserDeleteException() {
        super("user.password.delete", null);
    }
}
