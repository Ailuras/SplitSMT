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

(declare-sort var1995 0)
(declare-sort var649 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun contentType/-196148477 (var1995) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var1995 var1995)
(declare-const null-String String)
(declare-const var455 var1995) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var455 null-var1995)))
(define-const var1898 String (contentType/-196148477 var455)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String contentType> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var1898 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var172 Bool (isEmpty/-1285796103 var1898)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r6 = r3 
(assert (= (ite var172 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2283 String var1898) ; Statement: $r6 = r3 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {contentType/-196148477=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var1995=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var455=r0, var1898=r3, var649=null_type, var172=$z0, var2283=$r6}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var1995, r0=var455, r3=var1898, null_type=var649, $z0=var172, $r6=var2283}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String contentType>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r6 = r3;	$r6 = r3;	return $r6
;block_num 4