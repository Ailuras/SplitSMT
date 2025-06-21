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

(declare-sort var1261 0)
(declare-sort var1892 0)
(declare-sort var1208 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getClassLoader/-563698447 (ClassObject) var1892)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var1208) ClassObject)
(declare-fun cast-from-var1892-to-var1208 (var1892) var1208)
(declare-fun hashCode/1739917532 (var1208) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1261 var1261)
(declare-const null-ClassObject ClassObject)
(declare-const var1727 var1261) ; Statement: r13 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var1727 null-var1261)))
(declare-const var1120 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var1120 null-ClassObject)))
(assert true)
(define-const var270 var1892 (getClassLoader/-563698447 var1120)) ; Statement: r1 = virtualinvoke r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>() 
(define-const var2159 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2159)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2159!1 String)
(assert (= var2159!1 ""))
(assert true)
(define-const var448 String (getName/-1958580599 var1120)) ; Statement: $r3 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1545 String (append/672562846 var2159!1 var448)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2159!2 String)
(assert (= var2159!2 (str.++ var2159!1 var448)))
(assert true)
(define-const var2568 String (append/672562846 var1545 "[classloader=")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[classloader=") 
(declare-const var1545!1 String)
(assert (= var1545!1 (str.++ var1545 "[classloader=")))
(assert true)
(define-const var67 ClassObject (getClass/1258963082 (cast-from-var1892-to-var1208 var270))) ; Statement: $r5 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var41 String (getName/-1958580599 var67)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1244 String (append/672562846 var2568 var41)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2568!1 String)
(assert (= var2568!1 (str.++ var2568 var41)))
(assert true)
(define-const var3835 String (append/672562846 var1244 "@")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@") 
(declare-const var1244!1 String)
(assert (= var1244!1 (str.++ var1244 "@")))
(assert true)
(define-const var511 Int (hashCode/1739917532 (cast-from-var1892-to-var1208 var270))) ; Statement: $i0 = virtualinvoke r1.<java.lang.Object: int hashCode()>() 
(assert true)
(define-const var869 String (append/-1001720160 var3835 var511)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3835!1 String)
(assert (str.prefixof var3835 var3835!1))
(assert true)
(define-const var431 String (append/672562846 var869 "]")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var869!1 String)
(assert (= var869!1 (str.++ var869 "]")))
(assert true)
(define-const var2604 String (toString/-2075883882 var431)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {getClassLoader/-563698447=([java.lang.Class], java.lang.ClassLoader), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1892-to-var1208=([java.lang.ClassLoader], java.lang.Object), hashCode/1739917532=([java.lang.Object], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1261=org.apache.dubbo.config.ServiceConfigBase, var1727=r13, var1120=r0, var1892=java.lang.ClassLoader, var270=r1, var2159=$r2, var448=$r3, var1545=$r4, var2568=$r7, var1208=java.lang.Object, var67=$r5, var41=$r6, var1244=$r8, var3835=$r9, var511=$i0, var869=$r10, var431=$r11, var2604=$r12}
; {org.apache.dubbo.config.ServiceConfigBase=var1261, r13=var1727, r0=var1120, java.lang.ClassLoader=var1892, r1=var270, $r2=var2159, $r3=var448, $r4=var1545, $r7=var2568, java.lang.Object=var1208, $r5=var67, $r6=var41, $r8=var1244, $r9=var3835, $i0=var511, $r10=var869, $r11=var431, $r12=var2604}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r13 := @this: org.apache.dubbo.config.ServiceConfigBase;	r0 := @parameter0: java.lang.Class;	r1 = virtualinvoke r0.<java.lang.Class: java.lang.ClassLoader getClassLoader()>();	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[classloader=");	$r5 = virtualinvoke r1.<java.lang.Object: java.lang.Class getClass()>();	$r6 = virtualinvoke $r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@");	$i0 = virtualinvoke r1.<java.lang.Object: int hashCode()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1