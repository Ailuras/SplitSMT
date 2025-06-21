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

(declare-sort var3073 0)
(declare-sort var78 0)
(declare-sort var2590 0)
(declare-sort var3127 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2590_getUrl/-275947851 (var2590) var78)
(declare-fun cast-from-var3073-to-var2590 (var3073) var2590)
(declare-fun getParameter/-1307325648 (var78 String) String)
(declare-fun var3127_isEmpty/-813097145 (String) Bool)
(declare-const null-var3073 var3073)
(declare-const var1002 var3073) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1002 null-var3073)))
(define-const var2352 var78 (var2590_getUrl/-275947851 (cast-from-var3073-to-var2590 var1002))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2042 String (getParameter/-1307325648 var2352 "dubbo.tag")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
(define-const var2551 Bool (var3127_isEmpty/-813097145 var2042)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {var2590_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3073-to-var2590=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3127_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3073=org.apache.dubbo.rpc.Invoker, var1002=r0, var78=org.apache.dubbo.common.URL, var2590=org.apache.dubbo.common.Node, var2352=$r1, var2042=$r2, var3127=org.apache.dubbo.common.utils.StringUtils, var2551=$z0}
; {org.apache.dubbo.rpc.Invoker=var3073, r0=var1002, org.apache.dubbo.common.URL=var78, org.apache.dubbo.common.Node=var2590, $r1=var2352, $r2=var2042, org.apache.dubbo.common.utils.StringUtils=var3127, $z0=var2551}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r2);	return $z0
;block_num 1