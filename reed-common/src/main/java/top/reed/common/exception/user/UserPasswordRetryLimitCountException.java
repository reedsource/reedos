package top.reed.common.exception.user;

import java.io.Serial;

/**
 * 用户错误记数异常类
 *
 * @author reedsource
 */
public class UserPasswordRetryLimitCountException extends UserException {
    @Serial
    private static final long serialVersionUID = 1L;

    public UserPasswordRetryLimitCountException(int retryLimitCount) {
        super("user.password.retry.limit.count", new Object[]{retryLimitCount});
    }
}
