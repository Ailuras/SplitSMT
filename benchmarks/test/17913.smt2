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

(declare-sort var2741 0)
(declare-sort var3485 0)
(declare-sort var3135 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun headers/-578554792 (var2741) var3485)
(declare-fun var3485_get/-1031885745 (var3485 var3135) var3135)
(declare-fun cast-from-String-to-var3135 (String) var3135)
(declare-fun cast-from-var3135-to-String (var3135) String)
(declare-fun String_toString/-1426662429 (String) String)
(declare-const null-var2741 var2741)
(declare-const null-String String)
(declare-const var1194 var2741) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders 
(assert (not (= var1194 null-var2741)))
(declare-const var2938 String) ; Statement: r1 := @parameter0: java.lang.CharSequence 
(assert (not (= var2938 null-String)))
(define-const var2311 var3485 (headers/-578554792 var1194)) ; Statement: $r2 = r0.<org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders: io.netty.handler.codec.Headers headers> 
(define-const var281 var3135 (var3485_get/-1031885745 var2311 (cast-from-String-to-var3135 var2938))) ; Statement: $r3 = interfaceinvoke $r2.<io.netty.handler.codec.Headers: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1018 String (cast-from-var3135-to-String var281)) ; Statement: r4 = (java.lang.CharSequence) $r3 
 ; Statement: if r4 != null goto $r5 = interfaceinvoke r4.<java.lang.CharSequence: java.lang.String toString()>() 
(assert (not (= var1018 null-String))) ; Cond: r4 != null 
(define-const var2261 String (String_toString/-1426662429 var1018)) ; Statement: $r5 = interfaceinvoke r4.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r5 
(check-sat)
; {headers/-578554792=([org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders], io.netty.handler.codec.Headers), var3485_get/-1031885745=([io.netty.handler.codec.Headers, java.lang.Object], java.lang.Object), cast-from-String-to-var3135=([java.lang.CharSequence], java.lang.Object), cast-from-var3135-to-String=([java.lang.Object], java.lang.CharSequence), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String)}
; {var2741=org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders, var1194=r0, var2938=r1, var3485=io.netty.handler.codec.Headers, var2311=$r2, var3135=java.lang.Object, var281=$r3, var1018=r4, var2261=$r5}
; {org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders=var2741, r0=var1194, r1=var2938, io.netty.handler.codec.Headers=var3485, $r2=var2311, java.lang.Object=var3135, $r3=var281, r4=var1018, $r5=var2261}
;seq <java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders;	r1 := @parameter0: java.lang.CharSequence;	$r2 = r0.<org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders: io.netty.handler.codec.Headers headers>;	$r3 = interfaceinvoke $r2.<io.netty.handler.codec.Headers: java.lang.Object get(java.lang.Object)>(r1);	r4 = (java.lang.CharSequence) $r3;	if r4 != null goto $r5 = interfaceinvoke r4.<java.lang.CharSequence: java.lang.String toString()>();	$r5 = interfaceinvoke r4.<java.lang.CharSequence: java.lang.String toString()>();	return $r5
;block_num 3