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

(declare-sort var728 0)
(declare-sort var1590 0)
(declare-sort var2311 0)
(declare-sort var229 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var728) ClassObject)
(declare-fun append/-1031950772 (String var728) String)
(declare-fun cast-from-ClassObject-to-var728 (ClassObject) var728)
(declare-fun var2311_toString/-109309168 (var229) String)
(declare-fun cast-from-var1590-to-var229 (var1590) var229)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var728 var728)
(declare-const null-var1590 var1590)
(declare-const var1813 var728) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var1813 null-var728)))
 ; Statement: if r0 != null goto $r1 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>() 
(assert (not (not (= var1813 null-var728)))) ; Negate: Cond: r0 != null  
(declare-const var569 var1590) ; Statement: $r2 := @caughtexception 
(assert (not (= var569 null-var1590)))
(define-const var1621 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1621)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1621!1 String)
(assert (= var1621!1 ""))
(assert true)
(define-const var4 String (append/672562846 var1621!1 "<Fail toString of ")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<Fail toString of ") 
(declare-const var1621!2 String)
(assert (= var1621!2 (str.++ var1621!1 "<Fail toString of ")))
(assert true)
(define-const var1557 ClassObject (getClass/1258963082 var1813)) ; Statement: $r4 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var3219 String (append/-1031950772 var4 (cast-from-ClassObject-to-var728 var1557))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var4!1 String)
(assert (str.prefixof var4 var4!1))
(assert true)
(define-const var208 String (append/672562846 var3219 ", cause: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3219!1 String)
(assert (= var3219!1 (str.++ var3219 ", cause: ")))
(define-const var1584 String (var2311_toString/-109309168 (cast-from-var1590-to-var229 var569))) ; Statement: $r7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r2) 
(assert true)
(define-const var1202 String (append/672562846 var208 var1584)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var208!1 String)
(assert (= var208!1 (str.++ var208 var1584)))
(assert true)
(define-const var3828 String (append/672562846 var1202 ">")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(">") 
(declare-const var1202!1 String)
(assert (= var1202!1 (str.++ var1202 ">")))
(assert true)
(define-const var2392 String (toString/-2075883882 var3828)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r11 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var728=([java.lang.Class], java.lang.Object), var2311_toString/-109309168=([java.lang.Throwable], java.lang.String), cast-from-var1590-to-var229=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var728=java.lang.Object, var1813=r0, var1590=java.lang.Exception, var569=$r2, var1621=$r3, var4=$r5, var1557=$r4, var3219=$r6, var208=$r8, var2311=org.apache.dubbo.common.utils.StringUtils, var229=java.lang.Throwable, var1584=$r7, var1202=$r9, var3828=$r10, var2392=$r11}
; {java.lang.Object=var728, r0=var1813, java.lang.Exception=var1590, $r2=var569, $r3=var1621, $r5=var4, $r4=var1557, $r6=var3219, $r8=var208, org.apache.dubbo.common.utils.StringUtils=var2311, java.lang.Throwable=var229, $r7=var1584, $r9=var1202, $r10=var3828, $r11=var2392}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Object;	if r0 != null goto $r1 = virtualinvoke r0.<java.lang.Object: java.lang.String toString()>();	$r2 := @caughtexception;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("<Fail toString of ");	$r4 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String toString(java.lang.Throwable)>($r2);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(">");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	return $r11
;block_num 2