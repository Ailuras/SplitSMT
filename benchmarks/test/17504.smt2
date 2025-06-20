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

(declare-sort var914 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun val$next/1133642162 (var914) String)
(declare-fun String_toString/-1426662429 (String) String)
(declare-const null-var914 var914)
(declare-const null-String String)
(declare-const var3915 var914) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1 
(assert (not (= var3915 null-var914)))
(define-const var3599 String (val$next/1133642162 var3915)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1: java.lang.CharSequence val$next> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1: java.lang.CharSequence val$next> 
(assert (not (= var3599 null-String))) ; Cond: $r1 != null 
(define-const var781 String (val$next/1133642162 var3915)) ; Statement: $r2 = r0.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1: java.lang.CharSequence val$next> 
(define-const var3522 String (String_toString/-1426662429 var781)) ; Statement: $r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {val$next/1133642162=([org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1], java.lang.CharSequence), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String)}
; {var914=org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1, var3915=r0, var3599=$r1, var781=$r2, var3522=$r3}
; {org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1=var914, r0=var3915, $r1=var3599, $r2=var781, $r3=var3522}
;seq <java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1;	$r1 = r0.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1: java.lang.CharSequence val$next>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1: java.lang.CharSequence val$next>;	$r2 = r0.<org.apache.dubbo.remoting.http12.message.HttpHeadersMapAdapter$2$1$1: java.lang.CharSequence val$next>;	$r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>();	return $r3
;block_num 3