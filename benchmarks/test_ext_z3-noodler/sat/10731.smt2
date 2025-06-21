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

(declare-sort var1198 0)
(declare-sort var3070 0)
(declare-sort var196 0)
(declare-sort var2052 0)
(declare-sort var1949 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun matcher/468719934 (var196 String) var2052)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun matches/-149940873 (var2052) Bool)
(declare-fun var1949-init () var1949)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toString/750776585 (var196) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1949 String) void)
(declare-const null-var1198 var1198)
(declare-const null-String String)
(declare-const var1198-MAP_PATTERN var196)
(declare-const var1723 var1198) ; Statement: r16 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var1723 null-var1198)))
(declare-const var976 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var976 null-String)))
(declare-const var3012 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3012 null-String)))
(define-const var3237 var196 var1198-MAP_PATTERN) ; Statement: $r1 = <org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.util.regex.Pattern MAP_PATTERN> 
(assert true)
(define-const var574 var2052 (matcher/468719934 var3237 (cast-from-String-to-String var3012))) ; Statement: r2 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r0) 
(assert true)
(define-const var898 Bool (matches/-149940873 var574)) ; Statement: $z0 = virtualinvoke r2.<java.util.regex.Matcher: boolean matches()>() 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var898 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var622 var1949 var1949-init) ; Statement: $r3 = new java.lang.IllegalArgumentException 
(define-const var2187 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2187)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2187!1 String)
(assert (= var2187!1 ""))
(assert true)
(define-const var2883 String (append/672562846 var2187!1 "Map protobuf property ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Map protobuf property ") 
(declare-const var2187!2 String)
(assert (= var2187!2 (str.++ var2187!1 "Map protobuf property ")))
(assert true)
(define-const var2415 String (append/672562846 var2883 var976)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var2883!1 String)
(assert (= var2883!1 (str.++ var2883 var976)))
(assert true)
(define-const var2349 String (append/672562846 var2415 "of Type ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("of Type ") 
(declare-const var2415!1 String)
(assert (= var2415!1 (str.++ var2415 "of Type ")))
(assert true)
(define-const var1307 String (append/672562846 var2349 var3012)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2349!1 String)
(assert (= var2349!1 (str.++ var2349 var3012)))
(assert true)
(define-const var3971 String (append/672562846 var1307 " can\u0027t be parsed.The type name should mathch[")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" can\'t be parsed.The type name should mathch[") 
(declare-const var1307!1 String)
(assert (= var1307!1 (str.++ var1307 " can\u0027t be parsed.The type name should mathch[")))
(define-const var970 var196 var1198-MAP_PATTERN) ; Statement: $r10 = <org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.util.regex.Pattern MAP_PATTERN> 
(assert true)
(define-const var2592 String (toString/750776585 var970)) ; Statement: $r11 = virtualinvoke $r10.<java.util.regex.Pattern: java.lang.String toString()>() 
(assert true)
(define-const var2250 String (append/672562846 var3971 var2592)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3971!1 String)
(assert (= var3971!1 (str.++ var3971 var2592)))
(assert true)
(define-const var3509 String (append/672562846 var2250 "].")) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("].") 
(declare-const var2250!1 String)
(assert (= var2250!1 (str.++ var2250 "].")))
(assert true)
(define-const var755 String (toString/-2075883882 var3509)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var622 var755)) ; Statement: specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15) 

(declare-const var622!1 var1949)
(declare-const var755!1 String)
 ; Statement: throw $r3 
(check-sat)
; {matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), matches/-149940873=([java.util.regex.Matcher], boolean), var1949-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/750776585=([java.util.regex.Pattern], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1198=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var1723=r16, var976=r5, var3070=null_type, var3012=r0, var196=java.util.regex.Pattern, var3237=$r1, var2052=java.util.regex.Matcher, var574=r2, var898=$z0, var1949=java.lang.IllegalArgumentException, var622=$r3, var2187=$r4, var2883=$r6, var2415=$r7, var2349=$r8, var1307=$r9, var3971=$r12, var970=$r10, var2592=$r11, var2250=$r13, var3509=$r14, var755=$r15}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var1198, r16=var1723, r5=var976, null_type=var3070, r0=var3012, java.util.regex.Pattern=var196, $r1=var3237, java.util.regex.Matcher=var2052, r2=var574, $z0=var898, java.lang.IllegalArgumentException=var1949, $r3=var622, $r4=var2187, $r6=var2883, $r7=var2415, $r8=var2349, $r9=var1307, $r12=var3971, $r10=var970, $r11=var2592, $r13=var2250, $r14=var3509, $r15=var755}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.util.regex.Pattern: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r16 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = <org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.util.regex.Pattern MAP_PATTERN>;	r2 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r0);	$z0 = virtualinvoke r2.<java.util.regex.Matcher: boolean matches()>();	if $z0 != 0 goto return;	$r3 = new java.lang.IllegalArgumentException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Map protobuf property ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("of Type ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" can\'t be parsed.The type name should mathch[");	$r10 = <org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.util.regex.Pattern MAP_PATTERN>;	$r11 = virtualinvoke $r10.<java.util.regex.Pattern: java.lang.String toString()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("].");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r15);	throw $r3
;block_num 2