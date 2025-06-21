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

(declare-sort var2922 0)
(declare-sort var12 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun charset/-562224243 (var2922) String)
(declare-fun contentType/2057339566 (var2922) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var2922 var2922)
(declare-const null-String String)
(declare-const var1648 var2922) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var1648 null-var2922)))
(define-const var2811 String (charset/-562224243 var1648)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (not (= var2811 null-String)))) ; Negate: Cond: r3 != null  
(assert true)
(define-const var2280 String (contentType/2057339566 var1648)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType()>() 
 ; Statement: if r1 != null goto i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(java.lang.String)>("charset=") 
(assert (not (not (= var2280 null-String)))) ; Negate: Cond: r1 != null  
(define-const var2811!1 String "") ; Statement: r3 = "" 
 ; Statement: goto [?= r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3] 
(assert true) ; Non Conditional
(declare-const var1648!1 var2922)
(assert (not (= var1648!1 null-var2922)))
(assert (= (charset/-562224243 var1648!1) var2811!1)) ; Statement: r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3 
(assert true) ; Non Conditional
(assert true)
(define-const var2806 Bool (isEmpty/-1285796103 var2811!1)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (= (ite var2806 1 0) 0)) ; Cond: $z0 == 0 
(define-const var996 String var2811!1) ; Statement: $r5 = r3 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {charset/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), contentType/2057339566=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var2922=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var1648=r0, var2811=r3, var12=null_type, var2280=r1, var2806=$z0, var996=$r5}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var2922, r0=var1648, r3=var2811, null_type=var12, r1=var2280, $z0=var2806, $r5=var996}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType()>();	if r1 != null goto i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(java.lang.String)>("charset=");	r3 = "";	goto [?= r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3];	r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3;	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r5 = r3;	$r5 = r3;	return $r5
;block_num 7