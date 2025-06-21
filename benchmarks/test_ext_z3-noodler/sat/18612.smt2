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

(declare-sort var2900 0)
(declare-sort var2310 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun charset/-196148477 (var2900) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var2900 var2900)
(declare-const null-String String)
(declare-const var1439 var2900) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var1439 null-var2900)))
(define-const var1713 String (charset/-196148477 var1439)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String charset> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var1713 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var306 Bool (isEmpty/-1285796103 var1713)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r5 = r3 
(assert (= (ite var306 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1345 String var1713) ; Statement: $r5 = r3 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {charset/-196148477=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var2900=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var1439=r0, var1713=r3, var2310=null_type, var306=$z0, var1345=$r5}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var2900, r0=var1439, r3=var1713, null_type=var2310, $z0=var306, $r5=var1345}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String charset>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r5 = r3;	$r5 = r3;	return $r5
;block_num 4