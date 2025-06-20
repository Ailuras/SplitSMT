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

(declare-sort var3174 0)
(declare-sort var1248 0)
(declare-sort var1701 0)
(declare-sort var3554 0)
(declare-sort var1872 0)
(declare-sort var1334 0)
(declare-sort var3841 0)
(declare-sort var1711 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1872_stream/-1288525013 (var1872) var3554)
(declare-fun cast-from-var1701-to-var1872 (var1701) var1872)
(declare-fun var3841_bootstrap$/-881289170 (String) var1334)
(declare-fun var3554_filter/320182972 (var3554 var1334) var3554)
(declare-fun var3554_findFirst/-512239506 (var3554) var1711)
(declare-fun isPresent/580259846 (var1711) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3174 var3174)
(declare-const null-String String)
(declare-const null-var1701 var1701)
(declare-const var360 var3174) ; Statement: r10 := @this: org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd 
(assert (not (= var360 null-var3174)))
(declare-const var934 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var934 null-String)))
(declare-const var2946 var1701) ; Statement: r0 := @parameter1: java.util.List 
(assert (not (= var2946 null-var1701)))
(declare-const var1301 String) ; Statement: r12 := @parameter2: java.lang.String 
(assert (not (= var1301 null-String)))
(define-const var2502 var3554 (var1872_stream/-1288525013 (cast-from-var1701-to-var1872 var2946))) ; Statement: $r3 = interfaceinvoke r0.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var3933 var1334 (var3841_bootstrap$/-881289170 var934)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd$lambda_specifySingleApplication_0__853: java.util.function.Predicate bootstrap$(java.lang.String)>(r1) 
(define-const var849 var3554 (var3554_filter/320182972 var2502 var3933)) ; Statement: $r4 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r2) 
(define-const var2487 var1711 (var3554_findFirst/-512239506 var849)) ; Statement: r5 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.Optional findFirst()>() 
(assert true)
(define-const var777 Bool (isPresent/580259846 var2487)) ; Statement: $z0 = virtualinvoke r5.<java.util.Optional: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $r6 = new java.lang.StringBuilder 
(assert (= (ite var777 1 0) 0)) ; Cond: $z0 == 0 
(define-const var299 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var299)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var299!1 String)
(assert (= var299!1 ""))
(assert true)
(define-const var1732 String (append/672562846 var299!1 "Not exist application: ")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not exist application: ") 
(declare-const var299!2 String)
(assert (= var299!2 (str.++ var299!1 "Not exist application: ")))
(assert true)
(define-const var1600 String (append/672562846 var1732 var934)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var1732!1 String)
(assert (= var1732!1 (str.++ var1732 var934)))
(assert true)
(define-const var2641 String (toString/-2075883882 var1600)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var1872_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var1701-to-var1872=([java.util.List], java.util.Collection), var3841_bootstrap$/-881289170=([java.lang.String], java.util.function.Predicate), var3554_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var3554_findFirst/-512239506=([java.util.stream.Stream], java.util.Optional), isPresent/580259846=([java.util.Optional], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3174=org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd, var360=r10, var934=r1, var1248=null_type, var1701=java.util.List, var2946=r0, var1301=r12, var3554=java.util.stream.Stream, var1872=java.util.Collection, var2502=$r3, var1334=java.util.function.Predicate, var3841=org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd$lambda_specifySingleApplication_0__853, var3933=$r2, var849=$r4, var1711=java.util.Optional, var2487=r5, var777=$z0, var299=$r6, var1732=$r7, var1600=$r8, var2641=$r9}
; {org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd=var3174, r10=var360, r1=var934, null_type=var1248, java.util.List=var1701, r0=var2946, r12=var1301, java.util.stream.Stream=var3554, java.util.Collection=var1872, $r3=var2502, java.util.function.Predicate=var1334, org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd$lambda_specifySingleApplication_0__853=var3841, $r2=var3933, $r4=var849, java.util.Optional=var1711, r5=var2487, $z0=var777, $r6=var299, $r7=var1732, $r8=var1600, $r9=var2641}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd;	r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.util.List;	r12 := @parameter2: java.lang.String;	$r3 = interfaceinvoke r0.<java.util.List: java.util.stream.Stream stream()>();	$r2 = staticinvoke <org.apache.dubbo.qos.command.impl.DefaultMetricsReporterCmd$lambda_specifySingleApplication_0__853: java.util.function.Predicate bootstrap$(java.lang.String)>(r1);	$r4 = interfaceinvoke $r3.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r2);	r5 = interfaceinvoke $r4.<java.util.stream.Stream: java.util.Optional findFirst()>();	$z0 = virtualinvoke r5.<java.util.Optional: boolean isPresent()>();	if $z0 == 0 goto $r6 = new java.lang.StringBuilder;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Not exist application: ");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 2