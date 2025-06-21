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

(declare-sort var3127 0)
(declare-sort var102 0)
(declare-sort var878 0)
(declare-sort var474 0)
(declare-sort var1482 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var102_isSupportGson/-1995258908 () Bool)
(declare-fun var474-init () var474)
(declare-fun arr-var3127-init () (Array Int var3127))
(declare-fun cast-from-String-to-var3127 (String) var3127)
(declare-fun cast-from-var878-to-var1482 (var878) var1482)
(declare-fun getMessage/-261495068 (var1482) String)
(declare-fun String_format/1339386452 (String (Array Int var3127)) String)
(declare-fun <init>/-1084991535 (var474 String) void)
(declare-const null-var3127 var3127)
(declare-const null-var878 var878)
(declare-const null-__Array__Int__var3127__ (Array Int var3127))
(declare-const var3489 var3127) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var3489 null-var3127)))
(define-const var1554 Bool var102_isSupportGson/-1995258908) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.json.GsonUtils: boolean isSupportGson()>() 
 ; Statement: if $z0 != 0 goto $r1 = staticinvoke <org.apache.dubbo.common.json.GsonUtils: com.google.gson.Gson getGson()>() 
(assert (not (not (= (ite var1554 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(declare-const var1032 var878) ; Statement: $r4 := @caughtexception 
(assert (not (= var1032 null-var878)))
(define-const var3430 var474 var474-init) ; Statement: $r10 = new java.lang.RuntimeException 
(define-const var3093 (Array Int var3127) arr-var3127-init) ; Statement: $r6 = newarray (java.lang.Object)[3] 
(declare-const var3093!1 (Array Int var3127))
(assert (not (= var3093!1 null-__Array__Int__var3127__)))
(assert (= (select var3093!1 0) (cast-from-String-to-var3127 "gson"))) ; Statement: $r6[0] = "gson" 
(declare-const var3093!2 (Array Int var3127))
(assert (not (= var3093!2 null-__Array__Int__var3127__)))
(assert (= (select var3093!2 1) var3489)) ; Statement: $r6[1] = r0 
(define-const var1510 var1482 (cast-from-var878-to-var1482 var1032)) ; Statement: $r11 = (com.google.gson.JsonSyntaxException) $r4 
(assert true)
(define-const var2553 String (getMessage/-261495068 var1510)) ; Statement: $r7 = virtualinvoke $r11.<com.google.gson.JsonSyntaxException: java.lang.String getMessage()>() 
(declare-const var3093!3 (Array Int var3127))
(assert (not (= var3093!3 null-__Array__Int__var3127__)))
(assert (= (select var3093!3 2) (cast-from-String-to-var3127 var2553))) ; Statement: $r6[2] = $r7 
(define-const var1590 String (String_format/1339386452 "Generic serialization [%s] Json syntax exception thrown when parsing (object:%s ) error:%s" var3093!3)) ; Statement: $r8 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Generic serialization [%s] Json syntax exception thrown when parsing (object:%s ) error:%s", $r6) 
(assert true)
;(assert (<init>/-1084991535 var3430 var1590)) ; Statement: specialinvoke $r10.<java.lang.RuntimeException: void <init>(java.lang.String)>($r8) 

(declare-const var3430!1 var474)
(declare-const var1590!1 String)
 ; Statement: throw $r10 
(check-sat)
; {var102_isSupportGson/-1995258908=([], boolean), var474-init=([], java.lang.RuntimeException), arr-var3127-init=([], java.lang.Object[]), cast-from-String-to-var3127=([java.lang.String], java.lang.Object), cast-from-var878-to-var1482=([java.lang.Throwable], com.google.gson.JsonSyntaxException), getMessage/-261495068=([com.google.gson.JsonSyntaxException], java.lang.String), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3127=java.lang.Object, var3489=r0, var102=org.apache.dubbo.common.json.GsonUtils, var1554=$z0, var878=java.lang.Throwable, var1032=$r4, var474=java.lang.RuntimeException, var3430=$r10, var3093=$r6, var1482=com.google.gson.JsonSyntaxException, var1510=$r11, var2553=$r7, var1590=$r8}
; {java.lang.Object=var3127, r0=var3489, org.apache.dubbo.common.json.GsonUtils=var102, $z0=var1554, java.lang.Throwable=var878, $r4=var1032, java.lang.RuntimeException=var474, $r10=var3430, $r6=var3093, com.google.gson.JsonSyntaxException=var1482, $r11=var1510, $r7=var2553, $r8=var1590}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @parameter0: java.lang.Object;	$z0 = staticinvoke <org.apache.dubbo.common.json.GsonUtils: boolean isSupportGson()>();	if $z0 != 0 goto $r1 = staticinvoke <org.apache.dubbo.common.json.GsonUtils: com.google.gson.Gson getGson()>();	$r4 := @caughtexception;	$r10 = new java.lang.RuntimeException;	$r6 = newarray (java.lang.Object)[3];	$r6[0] = "gson";	$r6[1] = r0;	$r11 = (com.google.gson.JsonSyntaxException) $r4;	$r7 = virtualinvoke $r11.<com.google.gson.JsonSyntaxException: java.lang.String getMessage()>();	$r6[2] = $r7;	$r8 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Generic serialization [%s] Json syntax exception thrown when parsing (object:%s ) error:%s", $r6);	specialinvoke $r10.<java.lang.RuntimeException: void <init>(java.lang.String)>($r8);	throw $r10
;block_num 2