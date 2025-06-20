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

(declare-sort var52 0)
(declare-sort var2154 0)
(declare-sort var1694 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var2154) ClassObject)
(declare-fun cast-from-var52-to-var2154 (var52) var2154)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun source/-2084321508 (var52) var1694)
(declare-fun append/-1031950772 (String var2154) String)
(declare-fun cast-from-var1694-to-var2154 (var1694) var2154)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var52 var52)
(declare-const var3481 var52) ; Statement: r1 := @this: org.apache.dubbo.metrics.event.MetricsEvent 
(assert (not (= var3481 null-var52)))
(define-const var1888 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1888)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1888!1 String)
(assert (= var1888!1 ""))
(assert true)
(define-const var1547 ClassObject (getClass/1258963082 (cast-from-var52-to-var2154 var3481))) ; Statement: $r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3083 String (getName/-1958580599 var1547)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var175 String (append/672562846 var1888!1 var3083)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1888!2 String)
(assert (= var1888!2 (str.++ var1888!1 var3083)))
(assert true)
(define-const var2837 String (append/672562846 var175 "[source=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[source=") 
(declare-const var175!1 String)
(assert (= var175!1 (str.++ var175 "[source=")))
(define-const var916 var1694 (source/-2084321508 var3481)) ; Statement: $r5 = r1.<org.apache.dubbo.metrics.event.MetricsEvent: org.apache.dubbo.rpc.model.ApplicationModel source> 
(assert true)
(define-const var3463 String (append/-1031950772 var2837 (cast-from-var1694-to-var2154 var916))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2837!1 String)
(assert (str.prefixof var2837 var2837!1))
(assert true)
(define-const var2487 String (append/672562846 var3463 "]")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3463!1 String)
(assert (= var3463!1 (str.++ var3463 "]")))
(assert true)
(define-const var3775 String (toString/-2075883882 var2487)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var52-to-var2154=([org.apache.dubbo.metrics.event.MetricsEvent], java.lang.Object), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), source/-2084321508=([org.apache.dubbo.metrics.event.MetricsEvent], org.apache.dubbo.rpc.model.ApplicationModel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1694-to-var2154=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var52=org.apache.dubbo.metrics.event.MetricsEvent, var3481=r1, var1888=$r0, var2154=java.lang.Object, var1547=$r2, var3083=$r3, var175=$r4, var2837=$r6, var1694=org.apache.dubbo.rpc.model.ApplicationModel, var916=$r5, var3463=$r7, var2487=$r8, var3775=$r9}
; {org.apache.dubbo.metrics.event.MetricsEvent=var52, r1=var3481, $r0=var1888, java.lang.Object=var2154, $r2=var1547, $r3=var3083, $r4=var175, $r6=var2837, org.apache.dubbo.rpc.model.ApplicationModel=var1694, $r5=var916, $r7=var3463, $r8=var2487, $r9=var3775}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metrics.event.MetricsEvent;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[source=");	$r5 = r1.<org.apache.dubbo.metrics.event.MetricsEvent: org.apache.dubbo.rpc.model.ApplicationModel source>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1