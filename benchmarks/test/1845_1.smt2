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

(declare-sort var3874 0)
(declare-sort var3714 0)
(declare-sort var2488 0)
(declare-sort var2038 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2488_getUrl/-275947851 (var2488) var3714)
(declare-fun cast-from-var3874-to-var2488 (var3874) var2488)
(declare-fun getParameter/-1307325648 (var3714 String) String)
(declare-fun var2038_isEmpty/-813097145 (String) Bool)
(declare-const null-var3874 var3874)
(declare-const var1459 var3874) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1459 null-var3874)))
(define-const var612 var3714 (var2488_getUrl/-275947851 (cast-from-var3874-to-var2488 var1459))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2695 String (getParameter/-1307325648 var612 "dubbo.tag")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
(define-const var2413 Bool (var2038_isEmpty/-813097145 var2695)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: return $z0 
(check-sat)
; {var2488_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3874-to-var2488=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var2038_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3874=org.apache.dubbo.rpc.Invoker, var1459=r0, var3714=org.apache.dubbo.common.URL, var2488=org.apache.dubbo.common.Node, var612=$r1, var2695=r2, var2038=org.apache.dubbo.common.utils.StringUtils, var2413=$z0}
; {org.apache.dubbo.rpc.Invoker=var3874, r0=var1459, org.apache.dubbo.common.URL=var3714, org.apache.dubbo.common.Node=var2488, $r1=var612, r2=var2695, org.apache.dubbo.common.utils.StringUtils=var2038, $z0=var2413}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	return $z0
;block_num 1