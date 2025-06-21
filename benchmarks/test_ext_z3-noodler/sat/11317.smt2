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

(declare-sort var1166 0)
(declare-sort var1003 0)
(declare-sort var2776 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun type/-1713482392 (var1166) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun metricsLevel/-1713482392 (var1166) var1003)
(declare-fun hashCode/385986394 (var2776) Int)
(declare-fun cast-from-var1003-to-var2776 (var1003) var2776)
(declare-const null-var1166 var1166)
(declare-const var683 var1166) ; Statement: r0 := @this: org.apache.dubbo.metrics.model.key.MetricsPlaceValue 
(assert (not (= var683 null-var1166)))
(define-const var1439 String (type/-1713482392 var683)) ; Statement: $r1 = r0.<org.apache.dubbo.metrics.model.key.MetricsPlaceValue: java.lang.String type> 
(assert true)
(define-const var2089 Int (hashCode/-467973558 var1439)) ; Statement: i2 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
(define-const var3590 Int (* 31 var2089)) ; Statement: $i1 = 31 * i2 
(define-const var2860 var1003 (metricsLevel/-1713482392 var683)) ; Statement: $r2 = r0.<org.apache.dubbo.metrics.model.key.MetricsPlaceValue: org.apache.dubbo.metrics.model.key.MetricsLevel metricsLevel> 
(assert true)
(define-const var1661 Int (hashCode/385986394 (cast-from-var1003-to-var2776 var2860))) ; Statement: $i0 = virtualinvoke $r2.<org.apache.dubbo.metrics.model.key.MetricsLevel: int hashCode()>() 
(define-const var2271 Int (+ var3590 var1661)) ; Statement: i3 = $i1 + $i0 
 ; Statement: return i3 
(check-sat)
; {type/-1713482392=([org.apache.dubbo.metrics.model.key.MetricsPlaceValue], java.lang.String), hashCode/-467973558=([java.lang.String], int), metricsLevel/-1713482392=([org.apache.dubbo.metrics.model.key.MetricsPlaceValue], org.apache.dubbo.metrics.model.key.MetricsLevel), hashCode/385986394=([java.lang.Enum], int), cast-from-var1003-to-var2776=([org.apache.dubbo.metrics.model.key.MetricsLevel], java.lang.Enum)}
; {var1166=org.apache.dubbo.metrics.model.key.MetricsPlaceValue, var683=r0, var1439=$r1, var2089=i2, var3590=$i1, var1003=org.apache.dubbo.metrics.model.key.MetricsLevel, var2860=$r2, var2776=java.lang.Enum, var1661=$i0, var2271=i3}
; {org.apache.dubbo.metrics.model.key.MetricsPlaceValue=var1166, r0=var683, $r1=var1439, i2=var2089, $i1=var3590, org.apache.dubbo.metrics.model.key.MetricsLevel=var1003, $r2=var2860, java.lang.Enum=var2776, $i0=var1661, i3=var2271}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.metrics.model.key.MetricsPlaceValue;	$r1 = r0.<org.apache.dubbo.metrics.model.key.MetricsPlaceValue: java.lang.String type>;	i2 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	$i1 = 31 * i2;	$r2 = r0.<org.apache.dubbo.metrics.model.key.MetricsPlaceValue: org.apache.dubbo.metrics.model.key.MetricsLevel metricsLevel>;	$i0 = virtualinvoke $r2.<org.apache.dubbo.metrics.model.key.MetricsLevel: int hashCode()>();	i3 = $i1 + $i0;	return i3
;block_num 1