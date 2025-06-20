(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3300 0)
(declare-sort var3093 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun application/1727089910 (var3300) String)
(declare-fun var3093_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3300 var3300)
(declare-const var1711 var3300) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter 
(assert (not (= var1711 null-var3300)))
(define-const var2311 String (application/1727089910 var1711)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: java.lang.String application> 
(define-const var819 Bool (var3093_isNotEmpty/-1251449450 var2311)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var819 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {application/1727089910=([org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter], java.lang.String), var3093_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3300=org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter, var1711=r0, var2311=$r1, var3093=org.apache.dubbo.common.utils.StringUtils, var819=$z0}
; {org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter=var3300, r0=var1711, $r1=var2311, org.apache.dubbo.common.utils.StringUtils=var3093, $z0=var819}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter;	$r1 = r0.<org.apache.dubbo.rpc.cluster.router.tag.TagStateRouter: java.lang.String application>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto return;	return
;block_num 2