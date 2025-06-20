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

(declare-sort var3001 0)
(declare-sort var1716 0)
(declare-sort var2018 0)
(declare-sort var21 0)
(declare-sort var2917 0)
(declare-sort var1736 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2018_directory/1826808414 (var2018) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2917-init () var2917)
(declare-const null-var3001 var3001)
(declare-const null-var1716 var1716)
(declare-const null-var2018 var2018)
(declare-const null-String String)
(declare-const null-var1736 var1736)
(declare-const var1910 var3001) ; Statement: r8 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var1910 null-var3001)))
(declare-const var2538 var1716) ; Statement: r10 := @parameter0: java.util.Map 
(assert (not (= var2538 null-var1716)))
(declare-const var2646 var2018) ; Statement: r1 := @parameter1: org.apache.dubbo.common.extension.LoadingStrategy 
(assert (not (= var2646 null-var2018)))
(declare-const var2163 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2163 null-String)))
(define-const var2204 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2204)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2204!1 String)
(assert (= var2204!1 ""))
(define-const var1919 String (var2018_directory/1826808414 var2646)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.common.extension.LoadingStrategy: java.lang.String directory()>() 
(assert true)
(define-const var2151 String (append/672562846 var2204!1 var1919)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2204!2 String)
(assert (= var2204!2 (str.++ var2204!1 var1919)))
(assert true)
(define-const var2540 String (append/672562846 var2151 var2163)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var2151!1 String)
(assert (= var2151!1 (str.++ var2151 var2163)))
(assert true)
(define-const var3959 String (toString/-2075883882 var2540)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(define-const var1085 var2917 var2917-init) ; Statement: $r7 = new java.util.LinkedList 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2493 var1736) ; Statement: $r34 := @caughtexception 
(assert (not (= var2493 null-var1736)))
 ; Statement: throw $r34 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2018_directory/1826808414=([org.apache.dubbo.common.extension.LoadingStrategy], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2917-init=([], java.util.LinkedList)}
; {var3001=org.apache.dubbo.common.extension.ExtensionLoader, var1910=r8, var1716=java.util.Map, var2538=r10, var2018=org.apache.dubbo.common.extension.LoadingStrategy, var2646=r1, var2163=r3, var21=null_type, var2204=$r0, var1919=$r2, var2151=$r4, var2540=$r5, var3959=r6, var2917=java.util.LinkedList, var1085=$r7, var1736=java.lang.InterruptedException, var2493=$r34}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3001, r8=var1910, java.util.Map=var1716, r10=var2538, org.apache.dubbo.common.extension.LoadingStrategy=var2018, r1=var2646, r3=var2163, null_type=var21, $r0=var2204, $r2=var1919, $r4=var2151, $r5=var2540, r6=var3959, java.util.LinkedList=var2917, $r7=var1085, java.lang.InterruptedException=var1736, $r34=var2493}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r10 := @parameter0: java.util.Map;	r1 := @parameter1: org.apache.dubbo.common.extension.LoadingStrategy;	r3 := @parameter2: java.lang.String;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<org.apache.dubbo.common.extension.LoadingStrategy: java.lang.String directory()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = new java.util.LinkedList;	$r34 := @caughtexception;	throw $r34
;block_num 3