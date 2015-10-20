# vim:fileencoding=utf-8:ts=4:sw=4:sts=4:expandtab
from __future__ import (unicode_literals, division, absolute_import, print_function)

from powerline.theme import requires_segment_info


@requires_segment_info
def aws(pl, segment_info, region_var='AWS_REGION', account_var='BASTION_ENVIRONMENT'):
    region = segment_info['environ'].get('AWS_REGION', None)
    account = segment_info['environ'].get('BASTION_ENVIRONMENT', None)
    if all((region, account)):
        ret = [
                {
                    'contents': region,
                    'draw_inner_divider': True,
                },
                {
                    'contents': account
                }
              ]
        return ret
    return None


def history(pl):
    import zsh
    zsh.eval('_POWERLINE_REPLY=$(print -P "%!")')
    history_num = zsh.getvalue('_POWERLINE_REPLY')
    zsh.setvalue('_POWERLINE_REPLY', None)
    ret = [
        {
            'contents': history_num
        }
    ]
    return ret
