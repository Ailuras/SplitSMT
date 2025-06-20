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

(declare-sort var88 0)
(declare-sort var22 0)
(declare-sort var1746 0)
(declare-sort var1264 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun matcher/468719934 (var22 String) var1264)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun matches/-149940873 (var1264) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(declare-fun var22_compile/2141929305 (String) var22)
(declare-const null-String String)
(declare-const var1746-PORTS_PATTERN var22)
(declare-const var1755 String) ; Statement: r17 := @parameter0: java.lang.String 
(assert (not (= var1755 null-String)))
(define-const var85 String null-String) ; Statement: r18 = null 
(define-const var2662 var22 var1746-PORTS_PATTERN) ; Statement: $r0 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder: java.util.regex.Pattern PORTS_PATTERN> 
(assert true)
(define-const var2230 var1264 (matcher/468719934 var2662 (cast-from-String-to-String var1755))) ; Statement: r1 = virtualinvoke $r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r17) 
(assert true)
(define-const var3014 Bool (matches/-149940873 var2230)) ; Statement: $z0 = virtualinvoke r1.<java.util.regex.Matcher: boolean matches()>() 
 ; Statement: if $z0 == 0 goto $r2 = new java.lang.StringBuilder 
(assert (= (ite var3014 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1468 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1468)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1468!1 String)
(assert (= var1468!1 ""))
(assert true)
(define-const var3909 String (append/672562846 var1468!1 "\u005cQ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\Q") 
(declare-const var1468!2 String)
(assert (= var1468!2 (str.++ var1468!1 "\u005cQ")))
(assert true)
(define-const var102 String (append/672562846 var3909 var1755)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r17) 
(declare-const var3909!1 String)
(assert (= var3909!1 (str.++ var3909 var1755)))
(assert true)
(define-const var3670 String (append/672562846 var102 "\u005cE")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\E") 
(declare-const var102!1 String)
(assert (= var102!1 (str.++ var102 "\u005cE")))
(assert true)
(define-const var443 String (toString/-2075883882 var3670)) ; Statement: $r15 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var1918 String (replace/2138489945 var443 (cast-from-String-to-String "*") (cast-from-String-to-String "\u005cE.*\u005cQ"))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("*", "\\E.*\\Q") 
(define-const var3263 String var1918) ; Statement: r19 = $r16 
 ; Statement: if r18 == null goto $r21 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>(r19) 
(assert (= var85 null-String)) ; Cond: r18 == null 
(define-const var1447 var22 (var22_compile/2141929305 var3263)) ; Statement: $r21 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>(r19) 
 ; Statement: return $r21 
(check-sat)
; {matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), matches/-149940873=([java.util.regex.Matcher], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), var22_compile/2141929305=([java.lang.String], java.util.regex.Pattern)}
; {var1755=r17, var88=null_type, var85=r18, var22=java.util.regex.Pattern, var1746=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder, var2662=$r0, var1264=java.util.regex.Matcher, var2230=r1, var3014=$z0, var1468=$r2, var3909=$r3, var102=$r4, var3670=$r5, var443=$r15, var1918=$r16, var3263=r19, var1447=$r21}
; {r17=var1755, null_type=var88, r18=var85, java.util.regex.Pattern=var22, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder=var1746, $r0=var2662, java.util.regex.Matcher=var1264, r1=var2230, $z0=var3014, $r2=var1468, $r3=var3909, $r4=var102, $r5=var3670, $r15=var443, $r16=var1918, r19=var3263, $r21=var1447}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r17 := @parameter0: java.lang.String;	r18 = null;	$r0 = <org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder: java.util.regex.Pattern PORTS_PATTERN>;	r1 = virtualinvoke $r0.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r17);	$z0 = virtualinvoke r1.<java.util.regex.Matcher: boolean matches()>();	if $z0 == 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\Q");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r17);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\\E");	$r15 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = virtualinvoke $r15.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("*", "\\E.*\\Q");	r19 = $r16;	if r18 == null goto $r21 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>(r19);	$r21 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>(r19);	return $r21
;block_num 3