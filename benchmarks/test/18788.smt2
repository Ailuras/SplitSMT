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

(declare-sort var1646 0)
(declare-sort var2308 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun charset/-562224243 (var1646) String)
(declare-fun contentType/2057339566 (var1646) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var1646 var1646)
(declare-const null-String String)
(declare-const var2574 var1646) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var2574 null-var1646)))
(define-const var699 String (charset/-562224243 var2574)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (not (= var699 null-String)))) ; Negate: Cond: r3 != null  
(assert true)
(define-const var2917 String (contentType/2057339566 var2574)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType()>() 
 ; Statement: if r1 != null goto i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(java.lang.String)>("charset=") 
(assert (not (not (= var2917 null-String)))) ; Negate: Cond: r1 != null  
(define-const var699!1 String "") ; Statement: r3 = "" 
 ; Statement: goto [?= r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3] 
(assert true) ; Non Conditional
(declare-const var2574!1 var1646)
(assert (not (= var2574!1 null-var1646)))
(assert (= (charset/-562224243 var2574!1) var699!1)) ; Statement: r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3 
(assert true) ; Non Conditional
(assert true)
(define-const var358 Bool (isEmpty/-1285796103 var699!1)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (not (= (ite var358 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var833 String null-String) ; Statement: $r5 = null 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {charset/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), contentType/2057339566=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var1646=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var2574=r0, var699=r3, var2308=null_type, var2917=r1, var358=$z0, var833=$r5}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var1646, r0=var2574, r3=var699, null_type=var2308, r1=var2917, $z0=var358, $r5=var833}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	r1 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType()>();	if r1 != null goto i0 = virtualinvoke r1.<java.lang.String: int lastIndexOf(java.lang.String)>("charset=");	r3 = "";	goto [?= r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3];	r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> = r3;	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r5 = r3;	$r5 = null;	goto [?= return $r5];	return $r5
;block_num 7