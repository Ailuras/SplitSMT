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

(declare-sort var1611 0)
(declare-sort var111 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun contentType/-196148477 (var1611) String)
(define-fun isEmpty/-1285796103 ((s String)) Bool (= (str.len s) 0))
(declare-const null-var1611 var1611)
(declare-const null-String String)
(declare-const var1871 var1611) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse 
(assert (not (= var1871 null-var1611)))
(define-const var3044 String (contentType/-196148477 var1871)) ; Statement: r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String contentType> 
 ; Statement: if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
(assert (not (= var3044 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var1656 Bool (isEmpty/-1285796103 var3044)) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto $r6 = r3 
(assert (not (= (ite var1656 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var935 String null-String) ; Statement: $r6 = null 
 ; Statement: goto [?= return $r6] 
(assert true) ; Non Conditional
 ; Statement: return $r6 
(check-sat)
; {contentType/-196148477=([org.apache.dubbo.remoting.http12.message.DefaultHttpResponse], java.lang.String), isEmpty/-1285796103=([java.lang.String], boolean)}
; {var1611=org.apache.dubbo.remoting.http12.message.DefaultHttpResponse, var1871=r0, var3044=r3, var111=null_type, var1656=$z0, var935=$r6}
; {org.apache.dubbo.remoting.http12.message.DefaultHttpResponse=var1611, r0=var1871, r3=var3044, null_type=var111, $z0=var1656, $r6=var935}
;seq <java.lang.String: boolean isEmpty()>
;cnt {"<java.lang.String: boolean isEmpty()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.DefaultHttpResponse;	r3 = r0.<org.apache.dubbo.remoting.http12.message.DefaultHttpResponse: java.lang.String contentType>;	if r3 != null goto $z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	$z0 = virtualinvoke r3.<java.lang.String: boolean isEmpty()>();	if $z0 == 0 goto $r6 = r3;	$r6 = null;	goto [?= return $r6];	return $r6
;block_num 4