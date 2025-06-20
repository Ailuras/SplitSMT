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

(declare-sort var950 0)
(declare-sort var3277 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun charset/-562224243 (var950) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var950 var950)
(declare-const null-String String)
(declare-const var1386 var950) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var1386 null-var950)))
(define-const var1556 String (charset/-562224243 var1386)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var1556 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var2538 Bool (isEmpty/-1285796103 var1556)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (not (= (ite var2538 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3945 String null-String) ; Statement: $r5 = null 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {charset/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var950=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var1386=r0, var1556=r3, var3277=null_type, var2538=$z0, var3945=$r5}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var950, r0=var1386, r3=var1556, null_type=var3277, $z0=var2538, $r5=var3945}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String charset>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r5 = r3;	$r5 = null;	goto [?= return $r5];	return $r5
;block_num 4