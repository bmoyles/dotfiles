# vim:fileencoding=utf-8:ts=4:sw=4:sts=4:expandtab
from __future__ import (unicode_literals, division, absolute_import, print_function)

from powerline.theme import requires_segment_info


@requires_segment_info
def aws(pl, segment_info, region_var='AWS_REGION', env_var='BASTION_ENVIRONMENT'):
    region = segment_info['environ'].get(region_var, None)
    env = segment_info['environ'].get(env_var, None)
    if any((region, env)):
        ret = []
        if region is not None:
            ret.append({
                'contents': region,
                'draw_inner_divider': True,
                'highlight_groups': ['aws:region']
            })
        if env is not None:
            ret.append({
                'contents': env,
                'draw_inner_divider': True,
                'highlight_groups': ['aws:env']
            })
        return ret
    return None


def nl(pl):
    return [{
        'contents': None,
        'literal_contents': (
            0,
            ' ',
        )
    }]
