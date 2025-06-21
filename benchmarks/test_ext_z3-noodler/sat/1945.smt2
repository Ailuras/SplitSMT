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

(declare-sort var1442 0)
(declare-sort var661 0)
(declare-sort var1742 0)
(declare-sort var1067 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var661!class ClassObject)
(declare-fun getClassLoader/-563698447 (ClassObject) var1742)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getResources/-300194759 (var1742 String) var1067)
(declare-fun var1067_hasMoreElements/-1180312480 (var1067) Bool)
(declare-const null-String String)
(declare-const var2726 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2726 null-String)))
(define-const var2147 ClassObject var661!class) ; Statement: $r0 = class "Lorg/apache/dubbo/common/Version;" 
(assert true)
(define-const var3820 var1742 (getClassLoader/-563698447 var2147)) ; Statement: $r6 = virtualinvoke $r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var1761 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1761)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1761!1 String)
(assert (= var1761!1 ""))
(assert true)
(define-const var3629 String (append/672562846 var1761!1 "META-INF/dubbo-versions")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("META-INF/dubbo-versions") 
(declare-const var1761!2 String)
(assert (= var1761!2 (str.++ var1761!1 "META-INF/dubbo-versions")))
(assert true)
(define-const var1953 String (append/672562846 var3629 var2726)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var3629!1 String)
(assert (= var3629!1 (str.++ var3629 var2726)))
(assert true)
(define-const var748 String (toString/-2075883882 var1953)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1973 var1067 (getResources/-300194759 var3820 var748)) ; Statement: r7 = virtualinvoke $r6.<java.lang.ClassLoader: java.util.Enumeration getResources(java.lang.String)>($r5) 
(assert true) ; Non Conditional
(define-const var162 Bool (var1067_hasMoreElements/-1180312480 var1973)) ; Statement: $z0 = interfaceinvoke r7.<java.util.Enumeration: boolean hasMoreElements()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var162 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getResources/-300194759=([java.lang.ClassLoader, java.lang.String], java.util.Enumeration), var1067_hasMoreElements/-1180312480=([java.util.Enumeration], boolean)}
; {var2726=r2, var1442=null_type, var661=org.apache.dubbo.common.Version, var2147=$r0, var1742=java.lang.ClassLoader, var3820=$r6, var1761=$r1, var3629=$r3, var1953=$r4, var748=$r5, var1067=java.util.Enumeration, var1973=r7, var162=$z0}
; {r2=var2726, null_type=var1442, org.apache.dubbo.common.Version=var661, $r0=var2147, java.lang.ClassLoader=var1742, $r6=var3820, $r1=var1761, $r3=var3629, $r4=var1953, $r5=var748, java.util.Enumeration=var1067, r7=var1973, $z0=var162}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @parameter0: java.lang.String;	$r0 = class "Lorg/apache/dubbo/common/Version;";	$r6 = virtualinvoke $r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("META-INF/dubbo-versions");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	r7 = virtualinvoke $r6.<java.lang.ClassLoader: java.util.Enumeration getResources(java.lang.String)>($r5);	$z0 = interfaceinvoke r7.<java.util.Enumeration: boolean hasMoreElements()>();	if $z0 == 0 goto return;	return
;block_num 3