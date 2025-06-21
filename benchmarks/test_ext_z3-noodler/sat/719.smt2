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

(declare-sort var276 0)
(declare-sort var1453 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun application/-1975054663 (var276) String)
(declare-fun var1453_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var276 var276)
(declare-const var2519 var276) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter 
(assert (not (= var2519 null-var276)))
(define-const var717 String (application/-1975054663 var2519)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: java.lang.String application> 
(define-const var178 Bool (var1453_isNotEmpty/-1251449450 var717)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var178 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {application/-1975054663=([org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter], java.lang.String), var1453_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var276=org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter, var2519=r0, var717=$r1, var1453=org.apache.dubbo.common.utils.StringUtils, var178=$z0}
; {org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter=var276, r0=var2519, $r1=var717, org.apache.dubbo.common.utils.StringUtils=var1453, $z0=var178}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter;	$r1 = r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: java.lang.String application>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto return;	return
;block_num 2