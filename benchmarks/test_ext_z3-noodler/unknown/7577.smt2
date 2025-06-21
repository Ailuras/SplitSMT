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

(declare-sort var2289 0)
(declare-sort var1906 0)
(declare-sort var942 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var942_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2289 var2289)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1688 var2289) ; Statement: r10 := @this: org.apache.dubbo.rpc.model.ScopeModel 
(assert (not (= var1688 null-var2289)))
(declare-const var903 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var903 null-String)))
(declare-const var3745 Int) ; Statement: l0 := @parameter1: long 
(assert (not (= var3745 null-Int)))
(define-const var550 Bool (var942_hasText/853333513 (cast-from-String-to-String var903))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (= (ite var550 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1042 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1042)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1042!1 String)
(assert (= var1042!1 ""))
(assert true)
(define-const var78 String (append/672562846 var1042!1 var903)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1042!2 String)
(assert (= var1042!2 (str.++ var1042!1 var903)))
(assert true)
(define-const var2833 String (append/672562846 var78 ".")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var78!1 String)
(assert (= var78!1 (str.++ var78 ".")))
(assert true)
(define-const var2147 String (append/-901862667 var2833 var3745)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0) 
(declare-const var2833!1 String)
(assert (str.prefixof var2833 var2833!1))
(assert true)
(define-const var3914 String (toString/-2075883882 var2147)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {var942_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2289=org.apache.dubbo.rpc.model.ScopeModel, var1688=r10, var903=r0, var1906=null_type, var3745=l0, var942=org.apache.dubbo.common.utils.StringUtils, var550=$z0, var1042=$r5, var78=$r6, var2833=$r7, var2147=$r8, var3914=$r9}
; {org.apache.dubbo.rpc.model.ScopeModel=var2289, r10=var1688, r0=var903, null_type=var1906, l0=var3745, org.apache.dubbo.common.utils.StringUtils=var942, $z0=var550, $r5=var1042, $r6=var78, $r7=var2833, $r8=var2147, $r9=var3914}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r10 := @this: org.apache.dubbo.rpc.model.ScopeModel;	r0 := @parameter0: java.lang.String;	l0 := @parameter1: long;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 2