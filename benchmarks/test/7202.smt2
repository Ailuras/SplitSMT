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

(declare-sort var584 0)
(declare-sort var1780 0)
(declare-sort var2189 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1780_arrayToDelimitedString/-1603437942 ((Array Int var2189) String) String)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2189__ ((Array Int String)) (Array Int var2189))
(declare-fun var1780_isEmpty/-813097145 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3553 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3553 null-String)))
(declare-const var3896 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var3896 null-__Array__Int__String__)))
(define-const var2601 String (var1780_arrayToDelimitedString/-1603437942 (cast-from-__Array__Int__String__-to-__Array__Int__var2189__ var3896) ",")) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>(r0, ",") 
(define-const var3153 Bool (var1780_isEmpty/-813097145 var2601)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var3153 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1474 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1474)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1474!1 String)
(assert (= var1474!1 ""))
(assert true)
(define-const var2973 String (append/672562846 var1474!1 var3553)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3) 
(declare-const var1474!2 String)
(assert (= var1474!2 (str.++ var1474!1 var3553)))
(assert true)
(define-const var3428 String (append/672562846 var2973 ",")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var2973!1 String)
(assert (= var2973!1 (str.++ var2973 ",")))
(assert true)
(define-const var2600 String (append/672562846 var3428 var2601)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3428!1 String)
(assert (= var3428!1 (str.++ var3428 var2601)))
(assert true)
(define-const var1168 String (toString/-2075883882 var2600)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {var1780_arrayToDelimitedString/-1603437942=([java.lang.Object[], java.lang.String], java.lang.String), cast-from-__Array__Int__String__-to-__Array__Int__var2189__=([java.lang.String[]], java.lang.Object[]), var1780_isEmpty/-813097145=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3553=r3, var584=null_type, var3896=r0, var1780=org.apache.dubbo.common.utils.StringUtils, var2189=java.lang.Object, var2601=r1, var3153=$z0, var1474=$r2, var2973=$r4, var3428=$r5, var2600=$r6, var1168=$r7}
; {r3=var3553, null_type=var584, r0=var3896, org.apache.dubbo.common.utils.StringUtils=var1780, java.lang.Object=var2189, r1=var2601, $z0=var3153, $r2=var1474, $r4=var2973, $r5=var3428, $r6=var2600, $r7=var1168}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String arrayToDelimitedString(java.lang.Object[],java.lang.String)>(r0, ",");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 3