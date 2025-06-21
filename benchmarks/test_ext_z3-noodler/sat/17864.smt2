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

(declare-sort var168 0)
(declare-sort var3156 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun val$it/-682417614 (var168) Iterator)
(declare-fun Iterator_next/-1124697587 (Iterator) var3156)
(declare-fun cast-from-var3156-to-String (var3156) String)
(declare-fun String_toString/-1426662429 (String) String)
(declare-const null-var168 var168)
(declare-const null-String String)
(declare-const var3799 var168) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1 
(assert (not (= var3799 null-var168)))
(define-const var3570 Iterator (val$it/-682417614 var3799)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1: java.util.Iterator val$it> 
(define-const var1093 var3156 (Iterator_next/-1124697587 var3570)) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var3570!1 Iterator)
(define-const var1731 String (cast-from-var3156-to-String var1093)) ; Statement: r3 = (java.lang.CharSequence) $r2 
 ; Statement: if r3 != null goto $r4 = interfaceinvoke r3.<java.lang.CharSequence: java.lang.String toString()>() 
(assert (not (= var1731 null-String))) ; Cond: r3 != null 
(define-const var3416 String (String_toString/-1426662429 var1731)) ; Statement: $r4 = interfaceinvoke r3.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {val$it/-682417614=([org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1], java.util.Iterator), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var3156-to-String=([java.lang.Object], java.lang.CharSequence), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String)}
; {var168=org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1, var3799=r0, var3570=$r1, var3156=java.lang.Object, var1093=$r2, var1731=r3, var3416=$r4}
; {org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1=var168, r0=var3799, $r1=var3570, java.lang.Object=var3156, $r2=var1093, r3=var1731, $r4=var3416}
;seq <java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1;	$r1 = r0.<org.apache.dubbo.remoting.http12.netty4.NettyHttpHeaders$1$1: java.util.Iterator val$it>;	$r2 = interfaceinvoke $r1.<java.util.Iterator: java.lang.Object next()>();	r3 = (java.lang.CharSequence) $r2;	if r3 != null goto $r4 = interfaceinvoke r3.<java.lang.CharSequence: java.lang.String toString()>();	$r4 = interfaceinvoke r3.<java.lang.CharSequence: java.lang.String toString()>();	return $r4
;block_num 3