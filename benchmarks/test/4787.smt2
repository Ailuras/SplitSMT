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

(declare-sort var1319 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun host/-1719352014 (var1319) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun port/-1719352014 (var1319) Int)
(declare-const null-var1319 var1319)
(declare-const var2785 var1319) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.URLAddress 
(assert (not (= var2785 null-var1319)))
(define-const var638 String (host/-1719352014 var2785)) ; Statement: $r1 = r0.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String host> 
(assert true)
(define-const var769 Int (hashCode/-467973558 var638)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
(define-const var1774 Int (* var769 31)) ; Statement: $i2 = $i0 * 31 
(define-const var3388 Int (port/-1719352014 var2785)) ; Statement: $i1 = r0.<org.apache.dubbo.common.url.component.URLAddress: int port> 
(define-const var3241 Int (+ var1774 var3388)) ; Statement: $i3 = $i2 + $i1 
 ; Statement: return $i3 
(check-sat)
; {host/-1719352014=([org.apache.dubbo.common.url.component.URLAddress], java.lang.String), hashCode/-467973558=([java.lang.String], int), port/-1719352014=([org.apache.dubbo.common.url.component.URLAddress], int)}
; {var1319=org.apache.dubbo.common.url.component.URLAddress, var2785=r0, var638=$r1, var769=$i0, var1774=$i2, var3388=$i1, var3241=$i3}
; {org.apache.dubbo.common.url.component.URLAddress=var1319, r0=var2785, $r1=var638, $i0=var769, $i2=var1774, $i1=var3388, $i3=var3241}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.URLAddress;	$r1 = r0.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String host>;	$i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	$i2 = $i0 * 31;	$i1 = r0.<org.apache.dubbo.common.url.component.URLAddress: int port>;	$i3 = $i2 + $i1;	return $i3
;block_num 1