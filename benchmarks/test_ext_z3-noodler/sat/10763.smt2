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

(declare-sort var3312 0)
(declare-sort var196 0)
(declare-sort var2693 0)
(declare-sort var222 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun matcher/468719934 (var2693 String) var222)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun matches/-149940873 (var222) Bool)
(declare-const null-var3312 var3312)
(declare-const null-String String)
(declare-const var3312-MAP_PATTERN var2693)
(declare-const var3198 var3312) ; Statement: r16 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var3198 null-var3312)))
(declare-const var1088 String) ; Statement: r5 := @parameter0: java.lang.String 
(assert (not (= var1088 null-String)))
(declare-const var2692 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2692 null-String)))
(define-const var1294 var2693 var3312-MAP_PATTERN) ; Statement: $r1 = <org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.util.regex.Pattern MAP_PATTERN> 
(assert true)
(define-const var2817 var222 (matcher/468719934 var1294 (cast-from-String-to-String var2692))) ; Statement: r2 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r0) 
(assert true)
(define-const var811 Bool (matches/-149940873 var2817)) ; Statement: $z0 = virtualinvoke r2.<java.util.regex.Matcher: boolean matches()>() 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var811 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {matcher/468719934=([java.util.regex.Pattern, java.lang.CharSequence], java.util.regex.Matcher), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), matches/-149940873=([java.util.regex.Matcher], boolean)}
; {var3312=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var3198=r16, var1088=r5, var196=null_type, var2692=r0, var2693=java.util.regex.Pattern, var1294=$r1, var222=java.util.regex.Matcher, var2817=r2, var811=$z0}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var3312, r16=var3198, r5=var1088, null_type=var196, r0=var2692, java.util.regex.Pattern=var2693, $r1=var1294, java.util.regex.Matcher=var222, r2=var2817, $z0=var811}
;seq 
;cnt {}
;stmts r16 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r5 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$r1 = <org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder: java.util.regex.Pattern MAP_PATTERN>;	r2 = virtualinvoke $r1.<java.util.regex.Pattern: java.util.regex.Matcher matcher(java.lang.CharSequence)>(r0);	$z0 = virtualinvoke r2.<java.util.regex.Matcher: boolean matches()>();	if $z0 != 0 goto return;	return
;block_num 2