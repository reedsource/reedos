package top.reed.common.exception.user;

import java.io.Serial;

/**
 * 角色锁定异常类
 *
 * @author reedsource
 */
public class RoleBlockedException extends UserException {
    @Serial
    private static final long serialVersionUID = 1L;

    public RoleBlockedException() {
        super("role.blocked", null);
    }
}
