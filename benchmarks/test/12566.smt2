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

(declare-sort var837 0)
(declare-sort var1649 0)
(declare-sort var1155 0)
(declare-sort var701 0)
(declare-sort var2852 0)
(declare-sort var1042 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var701-init () var701)
(declare-fun <init>/-325640736 (var701) void)
(declare-fun var2852_add/328494887 (var2852 var1042) Bool)
(declare-fun cast-from-var701-to-var2852 (var701) var2852)
(declare-fun cast-from-String-to-var1042 (String) var1042)
(declare-fun getTotal/895776469 (var1155) Int)
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun getFailed/-71016635 (var1155) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun getActive/669422556 (var1155) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getSucceededAverageElapsed/-242465735 (var1155) Int)
(declare-fun append/-901862667 (String Int) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getSucceededMaxElapsed/-1101331392 (var1155) Int)
(declare-const null-var837 var837)
(declare-const null-String String)
(declare-const null-var1155 var1155)
(declare-const var1391 var837) ; Statement: r14 := @this: org.apache.dubbo.qos.command.impl.CountTelnet 
(assert (not (= var1391 null-var837)))
(declare-const var3549 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3549 null-String)))
(declare-const var586 var1155) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.RpcStatus 
(assert (not (= var586 null-var1155)))
(define-const var1202 var701 var701-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1202)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1202!1 var701)
;(assert (var2852_add/328494887 (cast-from-var701-to-var2852 var1202!1) (cast-from-String-to-var1042 var3549))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>(r1) 

(declare-const var1202!2 var701)
(declare-const var3549!1 String)
(assert true)
(define-const var1237 Int (getTotal/895776469 var586)) ; Statement: $l0 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: long getTotal()>() 
(define-const var579 String (String_valueOf/-107395227 var1237)) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>($l0) 
;(assert (var2852_add/328494887 (cast-from-var701-to-var2852 var1202!2) (cast-from-String-to-var1042 var579))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r3) 

(declare-const var1202!3 var701)
(declare-const var579!1 String)
(assert true)
(define-const var2256 Int (getFailed/-71016635 var586)) ; Statement: $i1 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: int getFailed()>() 
(define-const var679 String (String_valueOf/1240665136 var2256)) ; Statement: $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
;(assert (var2852_add/328494887 (cast-from-var701-to-var2852 var1202!3) (cast-from-String-to-var1042 var679))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r4) 

(declare-const var1202!4 var701)
(declare-const var679!1 String)
(assert true)
(define-const var1916 Int (getActive/669422556 var586)) ; Statement: $i2 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: int getActive()>() 
(define-const var2047 String (String_valueOf/1240665136 var1916)) ; Statement: $r5 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i2) 
;(assert (var2852_add/328494887 (cast-from-var701-to-var2852 var1202!4) (cast-from-String-to-var1042 var2047))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r5) 

(declare-const var1202!5 var701)
(declare-const var2047!1 String)
(define-const var142 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var142)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var142!1 String)
(assert (= var142!1 ""))
(assert true)
(define-const var1799 Int (getSucceededAverageElapsed/-242465735 var586)) ; Statement: $l3 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: long getSucceededAverageElapsed()>() 
(assert true)
(define-const var112 String (append/-901862667 var142!1 var1799)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l3) 
(declare-const var142!2 String)
(assert (str.prefixof var142!1 var142!2))
(assert true)
(define-const var2783 String (append/672562846 var112 "ms")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms") 
(declare-const var112!1 String)
(assert (= var112!1 (str.++ var112 "ms")))
(assert true)
(define-const var1944 String (toString/-2075883882 var2783)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2852_add/328494887 (cast-from-var701-to-var2852 var1202!5) (cast-from-String-to-var1042 var1944))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r9) 

(declare-const var1202!6 var701)
(declare-const var1944!1 String)
(define-const var3932 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3932)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3932!1 String)
(assert (= var3932!1 ""))
(assert true)
(define-const var152 Int (getSucceededMaxElapsed/-1101331392 var586)) ; Statement: $l4 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: long getSucceededMaxElapsed()>() 
(assert true)
(define-const var2377 String (append/-901862667 var3932!1 var152)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l4) 
(declare-const var3932!2 String)
(assert (str.prefixof var3932!1 var3932!2))
(assert true)
(define-const var2078 String (append/672562846 var2377 "ms")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms") 
(declare-const var2377!1 String)
(assert (= var2377!1 (str.++ var2377 "ms")))
(assert true)
(define-const var3519 String (toString/-2075883882 var2078)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2852_add/328494887 (cast-from-var701-to-var2852 var1202!6) (cast-from-String-to-var1042 var3519))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r13) 

(declare-const var1202!7 var701)
(declare-const var3519!1 String)
 ; Statement: return $r0 
(check-sat)
; {var701-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var2852_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var701-to-var2852=([java.util.ArrayList], java.util.List), cast-from-String-to-var1042=([java.lang.String], java.lang.Object), getTotal/895776469=([org.apache.dubbo.rpc.RpcStatus], long), String_valueOf/-107395227=([long], java.lang.String), getFailed/-71016635=([org.apache.dubbo.rpc.RpcStatus], int), String_valueOf/1240665136=([int], java.lang.String), getActive/669422556=([org.apache.dubbo.rpc.RpcStatus], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getSucceededAverageElapsed/-242465735=([org.apache.dubbo.rpc.RpcStatus], long), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getSucceededMaxElapsed/-1101331392=([org.apache.dubbo.rpc.RpcStatus], long)}
; {var837=org.apache.dubbo.qos.command.impl.CountTelnet, var1391=r14, var3549=r1, var1649=null_type, var1155=org.apache.dubbo.rpc.RpcStatus, var586=r2, var701=java.util.ArrayList, var1202=$r0, var2852=java.util.List, var1042=java.lang.Object, var1237=$l0, var579=$r3, var2256=$i1, var679=$r4, var1916=$i2, var2047=$r5, var142=$r6, var1799=$l3, var112=$r7, var2783=$r8, var1944=$r9, var3932=$r10, var152=$l4, var2377=$r11, var2078=$r12, var3519=$r13}
; {org.apache.dubbo.qos.command.impl.CountTelnet=var837, r14=var1391, r1=var3549, null_type=var1649, org.apache.dubbo.rpc.RpcStatus=var1155, r2=var586, java.util.ArrayList=var701, $r0=var1202, java.util.List=var2852, java.lang.Object=var1042, $l0=var1237, $r3=var579, $i1=var2256, $r4=var679, $i2=var1916, $r5=var2047, $r6=var142, $l3=var1799, $r7=var112, $r8=var2783, $r9=var1944, $r10=var3932, $l4=var152, $r11=var2377, $r12=var2078, $r13=var3519}
;seq <java.lang.String: java.lang.String valueOf(long)>;	<java.lang.String: java.lang.String valueOf(int)>;	<java.lang.String: java.lang.String valueOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String valueOf(long)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 2,"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r14 := @this: org.apache.dubbo.qos.command.impl.CountTelnet;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: org.apache.dubbo.rpc.RpcStatus;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>(r1);	$l0 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: long getTotal()>();	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>($l0);	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r3);	$i1 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: int getFailed()>();	$r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r4);	$i2 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: int getActive()>();	$r5 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i2);	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r5);	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$l3 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: long getSucceededAverageElapsed()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l3);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r9);	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$l4 = virtualinvoke r2.<org.apache.dubbo.rpc.RpcStatus: long getSucceededMaxElapsed()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l4);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r13);	return $r0
;block_num 1