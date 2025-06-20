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

(declare-sort var38 0)
(declare-sort var450 0)
(declare-sort var912 0)
(declare-sort var2194 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var450_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var2194-init () var2194)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2194 String) void)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var912 var912)
(declare-const var1082 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1082 null-String)))
(define-const var1681 Int null-Int) ; Statement: r12 = null 
(define-const var3238 Bool (var450_isNotEmpty/-1251449450 var1082)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return r12 
(assert (not (= (ite var3238 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var608 var912) ; Statement: $r6 := @caughtexception 
(assert (not (= var608 null-var912)))
(define-const var3091 var2194 var2194-init) ; Statement: $r7 = new java.lang.IllegalArgumentException 
(define-const var434 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var434)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var434!1 String)
(assert (= var434!1 ""))
(assert true)
(define-const var2053 String (append/672562846 var434!1 "Specified invalid port from env value:")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid port from env value:") 
(declare-const var434!2 String)
(assert (= var434!2 (str.++ var434!1 "Specified invalid port from env value:")))
(assert true)
(define-const var979 String (append/672562846 var2053 var1082)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2053!1 String)
(assert (= var2053!1 (str.++ var2053 var1082)))
(assert true)
(define-const var891 String (toString/-2075883882 var979)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3091 var891)) ; Statement: specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r11) 

(declare-const var3091!1 var2194)
(declare-const var891!1 String)
 ; Statement: throw $r7 
(check-sat)
; {var450_isNotEmpty/-1251449450=([java.lang.String], boolean), var2194-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1082=r0, var38=null_type, var1681=r12, var450=org.apache.dubbo.common.utils.StringUtils, var3238=$z0, var912=java.lang.Exception, var608=$r6, var2194=java.lang.IllegalArgumentException, var3091=$r7, var434=$r8, var2053=$r9, var979=$r10, var891=$r11}
; {r0=var1082, null_type=var38, r12=var1681, org.apache.dubbo.common.utils.StringUtils=var450, $z0=var3238, java.lang.Exception=var912, $r6=var608, java.lang.IllegalArgumentException=var2194, $r7=var3091, $r8=var434, $r9=var2053, $r10=var979, $r11=var891}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r12 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return r12;	$r6 := @caughtexception;	$r7 = new java.lang.IllegalArgumentException;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid port from env value:");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r7.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r11);	throw $r7
;block_num 2