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

(declare-sort var866 0)
(declare-sort var3976 0)
(declare-sort var3482 0)
(declare-sort var813 0)
(declare-sort var2261 0)
(declare-sort var2206 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3482-init () var3482)
(declare-fun <init>/964458484 (var3482) void)
(declare-fun var813_checkFileNameExist/-530515869 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var2261) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2206_warn/126438324 (var2206 String String String String var2261) void)
(declare-const null-var866 var866)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const null-var2261 var2261)
(declare-const var813-logger var2206)
(declare-const var250 var866) ; Statement: r4 := @parameter0: java.util.Set 
(assert (not (= var250 null-var866)))
(declare-const var3345 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3345 null-String)))
(declare-const var1972 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var1972 null-Bool)))
(declare-const var1254 Bool) ; Statement: z4 := @parameter3: boolean 
(assert (not (= var1254 null-Bool)))
(define-const var2917 var3482 var3482-init) ; Statement: $r0 = new java.util.Properties 
(assert true)
;(assert (<init>/964458484 var2917)) ; Statement: specialinvoke $r0.<java.util.Properties: void <init>()>() 

(declare-const var2917!1 var3482)
(define-const var2259 Bool (var813_checkFileNameExist/-530515869 var3345)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean checkFileNameExist(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto r80 = null 
(assert (not (= (ite var2259 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var1745 var2261) ; Statement: $r68 := @caughtexception 
(assert (not (= var1745 null-var2261)))
(define-const var84 var2206 var813-logger) ; Statement: $r70 = <org.apache.dubbo.common.utils.ConfigUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1339 String String-init) ; Statement: $r69 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1339)) ; Statement: specialinvoke $r69.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1339!1 String)
(assert (= var1339!1 ""))
(assert true)
(define-const var3952 String (append/672562846 var1339!1 "Failed to load ")) ; Statement: $r71 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load ") 
(declare-const var1339!2 String)
(assert (= var1339!2 (str.++ var1339!1 "Failed to load ")))
(assert true)
(define-const var1598 String (append/672562846 var3952 var3345)) ; Statement: $r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3952!1 String)
(assert (= var3952!1 (str.++ var3952 var3345)))
(assert true)
(define-const var3139 String (append/672562846 var1598 " file from ")) ; Statement: $r73 = virtualinvoke $r72.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" file from ") 
(declare-const var1598!1 String)
(assert (= var1598!1 (str.++ var1598 " file from ")))
(assert true)
(define-const var1557 String (append/672562846 var3139 var3345)) ; Statement: $r74 = virtualinvoke $r73.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3139!1 String)
(assert (= var3139!1 (str.++ var3139 var3345)))
(assert true)
(define-const var1867 String (append/672562846 var1557 "(ignore this file): ")) ; Statement: $r76 = virtualinvoke $r74.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(ignore this file): ") 
(declare-const var1557!1 String)
(assert (= var1557!1 (str.++ var1557 "(ignore this file): ")))
(assert true)
(define-const var3772 String (getMessage/849299655 var1745)) ; Statement: $r75 = virtualinvoke $r68.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var607 String (append/672562846 var1867 var3772)) ; Statement: $r77 = virtualinvoke $r76.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r75) 
(declare-const var1867!1 String)
(assert (= var1867!1 (str.++ var1867 var3772)))
(assert true)
(define-const var1834 String (toString/-2075883882 var607)) ; Statement: $r78 = virtualinvoke $r77.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2206_warn/126438324 var84 "0-22" "" "" var1834 var1745)) ; Statement: interfaceinvoke $r70.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-22", "", "", $r78, $r68) 

(declare-const var84!1 var2206)
(declare-const var2766 String)
(declare-const var138 String)
(declare-const var138!1 String)
(declare-const var1834!1 String)
(declare-const var1745!1 var2261)
(assert true) ; Non Conditional
 ; Statement: return $r0 
(check-sat)
; {var3482-init=([], java.util.Properties), <init>/964458484=([java.util.Properties], void), var813_checkFileNameExist/-530515869=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2206_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var866=java.util.Set, var250=r4, var3345=r1, var3976=null_type, var1972=z2, var1254=z4, var3482=java.util.Properties, var2917=$r0, var813=org.apache.dubbo.common.utils.ConfigUtils, var2259=$z0, var2261=java.lang.Throwable, var1745=$r68, var2206=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var84=$r70, var1339=$r69, var3952=$r71, var1598=$r72, var3139=$r73, var1557=$r74, var1867=$r76, var3772=$r75, var607=$r77, var1834=$r78, var2766="0-22", var138=""}
; {java.util.Set=var866, r4=var250, r1=var3345, null_type=var3976, z2=var1972, z4=var1254, java.util.Properties=var3482, $r0=var2917, org.apache.dubbo.common.utils.ConfigUtils=var813, $z0=var2259, java.lang.Throwable=var2261, $r68=var1745, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2206, $r70=var84, $r69=var1339, $r71=var3952, $r72=var1598, $r73=var3139, $r74=var1557, $r76=var1867, $r75=var3772, $r77=var607, $r78=var1834, "0-22"=var2766, ""=var138}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @parameter0: java.util.Set;	r1 := @parameter1: java.lang.String;	z2 := @parameter2: boolean;	z4 := @parameter3: boolean;	$r0 = new java.util.Properties;	specialinvoke $r0.<java.util.Properties: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: boolean checkFileNameExist(java.lang.String)>(r1);	if $z0 == 0 goto r80 = null;	$r68 := @caughtexception;	$r70 = <org.apache.dubbo.common.utils.ConfigUtils: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r69 = new java.lang.StringBuilder;	specialinvoke $r69.<java.lang.StringBuilder: void <init>()>();	$r71 = virtualinvoke $r69.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to load ");	$r72 = virtualinvoke $r71.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r73 = virtualinvoke $r72.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" file from ");	$r74 = virtualinvoke $r73.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r76 = virtualinvoke $r74.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("(ignore this file): ");	$r75 = virtualinvoke $r68.<java.lang.Throwable: java.lang.String getMessage()>();	$r77 = virtualinvoke $r76.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r75);	$r78 = virtualinvoke $r77.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r70.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-22", "", "", $r78, $r68);	return $r0
;block_num 3