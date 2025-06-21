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

(declare-sort var899 0)
(declare-sort var875 0)
(declare-sort var1041 0)
(declare-sort var2138 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1041_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getBytes/1068683673 (String) (Array Int Int))
(declare-fun deserialize/-673197245 (var899 (Array Int Int) ClassObject) var2138)
(declare-const null-var899 var899)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var1883 var899) ; Statement: r1 := @this: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec 
(assert (not (= var1883 null-var899)))
(declare-const var1617 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1617 null-String)))
(declare-const var3095 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var3095 null-ClassObject)))
(define-const var1884 Bool (var1041_isBlank/-523695098 (cast-from-String-to-String var1617))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>() 
(assert (= (ite var1884 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1328 (Array Int Int) (getBytes/1068683673 var1617)) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>() 
(assert true)
(define-const var1249 var2138 (deserialize/-673197245 var1883 var1328 var3095)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.spring.security.jackson.ObjectMapperCodec: java.lang.Object deserialize(byte[],java.lang.Class)>($r3, r2) 
 ; Statement: return $r4 
(check-sat)
; {var1041_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getBytes/1068683673=([java.lang.String], byte[]), deserialize/-673197245=([org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, byte[], java.lang.Class], java.lang.Object)}
; {var899=org.apache.dubbo.spring.security.jackson.ObjectMapperCodec, var1883=r1, var1617=r0, var875=null_type, var3095=r2, var1041=org.apache.dubbo.common.utils.StringUtils, var1884=$z0, var1328=$r3, var2138=java.lang.Object, var1249=$r4}
; {org.apache.dubbo.spring.security.jackson.ObjectMapperCodec=var899, r1=var1883, r0=var1617, null_type=var875, r2=var3095, org.apache.dubbo.common.utils.StringUtils=var1041, $z0=var1884, $r3=var1328, java.lang.Object=var2138, $r4=var1249}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: byte[] getBytes()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: byte[] getBytes()>": 1}
;stmts r1 := @this: org.apache.dubbo.spring.security.jackson.ObjectMapperCodec;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>();	$r3 = virtualinvoke r0.<java.lang.String: byte[] getBytes()>();	$r4 = virtualinvoke r1.<org.apache.dubbo.spring.security.jackson.ObjectMapperCodec: java.lang.Object deserialize(byte[],java.lang.Class)>($r3, r2);	return $r4
;block_num 2