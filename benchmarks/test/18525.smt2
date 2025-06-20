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

(declare-sort var2505 0)
(declare-sort var3172 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun contentType/-562224243 (var2505) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var2505 var2505)
(declare-const null-String String)
(declare-const var3901 var2505) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest 
(assert (not (= var3901 null-var2505)))
(define-const var183 String (contentType/-562224243 var3901)) ; Statement: r4 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType> 
 ; Statement: if r4 != null goto $z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var183 null-String))) ; Cond: r4 != null 
(assert true)
(define-const var305 Bool (isEmpty/-1285796103 var183)) ; Statement: $z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r7 = r4 
(assert (not (= (ite var305 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2701 String null-String) ; Statement: $r7 = null 
 ; Statement: goto [?= return $r7] 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {contentType/-562224243=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var2505=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3901=r0, var183=r4, var3172=null_type, var305=$z0, var2701=$r7}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var2505, r0=var3901, r4=var183, null_type=var3172, $z0=var305, $r7=var2701}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpRequest;	r4 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpRequest: java.lang.String contentType>;	if r4 != null goto $z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r4.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r7 = r4;	$r7 = null;	goto [?= return $r7];	return $r7
;block_num 4