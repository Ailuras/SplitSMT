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

(declare-sort var2573 0)
(declare-sort var1186 0)
(declare-sort var1080 0)
(declare-sort var2351 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2351_getUrl/-275947851 (var2351) var1080)
(declare-fun cast-from-var1186-to-var2351 (var1186) var2351)
(declare-fun getParameter/-1307325648 (var1080 String) String)
(declare-const null-String String)
(declare-const null-var1186 var1186)
(declare-const var120 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var120 null-String)))
(declare-const var1936 var1186) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1936 null-var1186)))
(define-const var2038 var1080 (var2351_getUrl/-275947851 (cast-from-var1186-to-var2351 var1936))) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1087 String (getParameter/-1307325648 var2038 "dubbo.tag")) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
(assert true)
(define-const var52 Bool (= var120 var1087)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {var2351_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var1186-to-var2351=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var120=r0, var2573=null_type, var1186=org.apache.dubbo.rpc.Invoker, var1936=r1, var1080=org.apache.dubbo.common.URL, var2351=org.apache.dubbo.common.Node, var2038=$r2, var1087=$r3, var52=$z0}
; {r0=var120, null_type=var2573, org.apache.dubbo.rpc.Invoker=var1186, r1=var1936, org.apache.dubbo.common.URL=var1080, org.apache.dubbo.common.Node=var2351, $r2=var2038, $r3=var1087, $z0=var52}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.rpc.Invoker;	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3);	return $z0
;block_num 1