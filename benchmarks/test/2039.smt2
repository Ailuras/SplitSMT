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

(declare-sort var3550 0)
(declare-sort var820 0)
(declare-sort var3570 0)
(declare-sort var642 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var642_getUrl/-275947851 (var642) var3570)
(declare-fun cast-from-var820-to-var642 (var820) var642)
(declare-fun getParameter/-1307325648 (var3570 String) String)
(declare-const null-String String)
(declare-const null-var820 var820)
(declare-const var743 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var743 null-String)))
(declare-const var2692 var820) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2692 null-var820)))
(define-const var2248 var3570 (var642_getUrl/-275947851 (cast-from-var820-to-var642 var2692))) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2547 String (getParameter/-1307325648 var2248 "dubbo.tag")) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag") 
(assert true)
(define-const var3480 Bool (= var743 var2547)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: return $z0 
(check-sat)
; {var642_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var820-to-var642=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String)}
; {var743=r0, var3550=null_type, var820=org.apache.dubbo.rpc.Invoker, var2692=r1, var3570=org.apache.dubbo.common.URL, var642=org.apache.dubbo.common.Node, var2248=$r2, var2547=$r3, var3480=$z0}
; {r0=var743, null_type=var3550, org.apache.dubbo.rpc.Invoker=var820, r1=var2692, org.apache.dubbo.common.URL=var3570, org.apache.dubbo.common.Node=var642, $r2=var2248, $r3=var2547, $z0=var3480}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.rpc.Invoker;	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("dubbo.tag");	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r3);	return $z0
;block_num 1