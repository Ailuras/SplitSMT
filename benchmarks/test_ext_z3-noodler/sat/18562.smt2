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

(declare-sort var1746 0)
(declare-sort var3917 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun contentType/-562224243 (var1746) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var1746 var1746)
(declare-const null-String String)
(declare-const var2176 var1746) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var2176 null-var1746)))
(define-const var3125 String (contentType/-562224243 var2176)) ; Statement: r4 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType> 
 ; Statement: if r4 != null goto $z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var3125 null-String))) ; Cond: r4 != null 
(assert true)
(define-const var3731 Bool (isEmpty/-1285796103 var3125)) ; Statement: $z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r7 = r4 
(assert (= (ite var3731 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3186 String var3125) ; Statement: $r7 = r4 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {contentType/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var1746=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var2176=r0, var3125=r4, var3917=null_type, var3731=$z0, var3186=$r7}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var1746, r0=var2176, r4=var3125, null_type=var3917, $z0=var3731, $r7=var3186}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r4 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType>;	if r4 != null goto $z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r7 = r4;	$r7 = r4;	return $r7
;block_num 4