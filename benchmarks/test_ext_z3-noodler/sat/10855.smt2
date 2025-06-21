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

(declare-sort var2926 0)
(declare-sort var3932 0)
(declare-sort var447 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-fun var447_toLowerCase/1461689736 (Int) Int)
(declare-fun String-init () String)
(declare-fun <init>/-915723298 (String (Array Int Int)) void)
(declare-const null-var2926 var2926)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var3517 var2926) ; Statement: r3 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder 
(assert (not (= var3517 null-var2926)))
(declare-const var1182 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1182 null-String)))
(assert true)
(define-const var3794 (Array Int Int) (toCharArray/415275702 var1182)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>() 
(define-const var3987 Int (select var3794 0)) ; Statement: $c0 = r1[0] 
(define-const var2425 Int (var447_toLowerCase/1461689736 var3987)) ; Statement: $c1 = staticinvoke <java.lang.Character: char toLowerCase(char)>($c0) 
(declare-const var3794!1 (Array Int Int))
(assert (not (= var3794!1 null-__Array__Int__Int__)))
(assert (= (select var3794!1 0) var2425)) ; Statement: r1[0] = $c1 
(define-const var1410 String String-init) ; Statement: $r2 = new java.lang.String 
(assert true)
;(assert (<init>/-915723298 var1410 var3794!1)) ; Statement: specialinvoke $r2.<java.lang.String: void <init>(char[])>(r1) 

(declare-const var1410!1 String)
(declare-const var3794!2 (Array Int Int))
 ; Statement: return $r2 
(check-sat)
; {toCharArray/415275702=([java.lang.String], char[]), var447_toLowerCase/1461689736=([char], char), String-init=([], java.lang.String), <init>/-915723298=([java.lang.String, char[]], void)}
; {var2926=org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder, var3517=r3, var1182=r0, var3932=null_type, var3794=r1, var3987=$c0, var447=java.lang.Character, var2425=$c1, var1410=$r2}
; {org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder=var2926, r3=var3517, r0=var1182, null_type=var3932, r1=var3794, $c0=var3987, java.lang.Character=var447, $c1=var2425, $r2=var1410}
;seq <java.lang.String: char[] toCharArray()>;	<java.lang.String: void <init>(char[])>
;cnt {"<java.lang.String: char[] toCharArray()>": 1,"<java.lang.String: void <init>(char[])>": 1}
;stmts r3 := @this: org.apache.dubbo.metadata.definition.protobuf.ProtobufTypeBuilder;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>();	$c0 = r1[0];	$c1 = staticinvoke <java.lang.Character: char toLowerCase(char)>($c0);	r1[0] = $c1;	$r2 = new java.lang.String;	specialinvoke $r2.<java.lang.String: void <init>(char[])>(r1);	return $r2
;block_num 1