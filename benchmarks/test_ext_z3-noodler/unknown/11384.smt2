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

(declare-sort var1653 0)
(declare-sort var356 0)
(declare-sort var457 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun metricsKeyWrapper/-1616433758 (var1653) var356)
(declare-fun append/-1031950772 (String var457) String)
(declare-fun cast-from-var356-to-var457 (var356) var457)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1653 var1653)
(declare-const var1847 var1653) ; Statement: r1 := @this: org.apache.dubbo.metrics.model.container.LongContainer 
(assert (not (= var1847 null-var1653)))
(define-const var818 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var818)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var818!1 String)
(assert (= var818!1 ""))
(assert true)
(define-const var590 String (append/672562846 var818!1 "LongContainer{metricsKeyWrapper=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("LongContainer{metricsKeyWrapper=") 
(declare-const var818!2 String)
(assert (= var818!2 (str.++ var818!1 "LongContainer{metricsKeyWrapper=")))
(define-const var2000 var356 (metricsKeyWrapper/-1616433758 var1847)) ; Statement: $r2 = r1.<org.apache.dubbo.metrics.model.container.LongContainer: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper metricsKeyWrapper> 
(assert true)
(define-const var850 String (append/-1031950772 var590 (cast-from-var356-to-var457 var2000))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var590!1 String)
(assert (str.prefixof var590 var590!1))
(assert true)
(define-const var1157 String (append/-1166366385 var850 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var850!1 String)
(assert (str.prefixof var850 var850!1))
(assert true)
(define-const var2352 String (toString/-2075883882 var1157)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), metricsKeyWrapper/-1616433758=([org.apache.dubbo.metrics.model.container.LongContainer], org.apache.dubbo.metrics.model.key.MetricsKeyWrapper), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var356-to-var457=([org.apache.dubbo.metrics.model.key.MetricsKeyWrapper], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1653=org.apache.dubbo.metrics.model.container.LongContainer, var1847=r1, var818=$r0, var590=$r3, var356=org.apache.dubbo.metrics.model.key.MetricsKeyWrapper, var2000=$r2, var457=java.lang.Object, var850=$r4, var1157=$r5, var2352=$r6}
; {org.apache.dubbo.metrics.model.container.LongContainer=var1653, r1=var1847, $r0=var818, $r3=var590, org.apache.dubbo.metrics.model.key.MetricsKeyWrapper=var356, $r2=var2000, java.lang.Object=var457, $r4=var850, $r5=var1157, $r6=var2352}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.model.container.LongContainer;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("LongContainer{metricsKeyWrapper=");	$r2 = r1.<org.apache.dubbo.metrics.model.container.LongContainer: org.apache.dubbo.metrics.model.key.MetricsKeyWrapper metricsKeyWrapper>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1