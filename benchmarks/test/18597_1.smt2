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

(declare-sort var342 0)
(declare-sort var2290 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun charset/-196148477 (var342) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var342 var342)
(declare-const null-String String)
(declare-const var477 var342) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var477 null-var342)))
(define-const var271 String (charset/-196148477 var477)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String charset> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var271 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var3759 Bool (isEmpty/-1285796103 var271)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (not (= (ite var3759 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3913 String null-String) ; Statement: $r5 = null 
 ; Statement: goto [?= return $r5] 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {charset/-196148477=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var342=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var477=r0, var271=r3, var2290=null_type, var3759=$z0, var3913=$r5}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var342, r0=var477, r3=var271, null_type=var2290, $z0=var3759, $r5=var3913}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String charset>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r5 = r3;	$r5 = null;	goto [?= return $r5];	return $r5
;block_num 4