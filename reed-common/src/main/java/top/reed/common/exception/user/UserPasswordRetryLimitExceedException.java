package top.reed.common.exception.user;

import java.io.Serial;

/**
 * 用户错误最大次数异常类
 *
 * @author reedsource
 */
public class UserPasswordRetryLimitExceedException extends UserException {
    @Serial
    private static final long serialVersionUID = 1L;

    public UserPasswordRetryLimitExceedException(int retryLimitCount) {
        super("user.password.retry.limit.exceed", new Object[]{retryLimitCount});
    }
}
