package top.reed.common.exception.user;

import top.reed.common.exception.base.BaseException;

/**
 * 用户信息异常类
 *
 * @author reedsource
 */
public class UserException extends BaseException {
    private static final long serialVersionUID = 1L;

    public UserException(String code, Object[] args) {
        super("user", code, args, null);
    }
}
