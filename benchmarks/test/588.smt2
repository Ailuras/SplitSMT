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

(declare-sort var2533 0)
(declare-sort var2757 0)
(declare-sort var3715 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameterAndDecoded/384969937 (var2757 String) String)
(declare-fun var3715_isEmpty/-813097145 (String) Bool)
(declare-const null-var2533 var2533)
(declare-const null-var2757 var2757)
(declare-const var418 var2533) ; Statement: r3 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter 
(assert (not (= var418 null-var2533)))
(declare-const var768 var2757) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var768 null-var2757)))
(assert true)
(define-const var3316 String (getParameterAndDecoded/384969937 var768 "rule")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>("rule") 
(define-const var2669 Bool (var3715_isEmpty/-813097145 var3316)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return r1 
(assert (= (ite var2669 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r1 
(check-sat)
; {getParameterAndDecoded/384969937=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3715_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2533=org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter, var418=r3, var2757=org.apache.dubbo.common.URL, var768=r0, var3316=r1, var3715=org.apache.dubbo.common.utils.StringUtils, var2669=$z0}
; {org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter=var2533, r3=var418, org.apache.dubbo.common.URL=var2757, r0=var768, r1=var3316, org.apache.dubbo.common.utils.StringUtils=var3715, $z0=var2669}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameterAndDecoded(java.lang.String)>("rule");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto return r1;	return r1
;block_num 2