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

(declare-sort var1426 0)
(declare-sort var643 0)
(declare-sort var558 0)
(declare-sort var2636 0)
(declare-sort var1942 0)
(declare-sort var3358 0)
(declare-sort var296 0)
(declare-sort var3192 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var1426) var643)
(declare-fun toInstant/-822818885 (var643) var558)
(declare-fun var2636_systemDefault/1019915793 () var2636)
(declare-fun var1942_ofInstant/129408697 (var558 var2636) var1942)
(declare-fun format/372879155 (var1942 var3358) String)
(declare-fun getOutTime/324948452 (var1426) var643)
(declare-fun get/-1007821573 (var1426 String) var296)
(declare-fun append/-1031950772 (String var296) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var3192_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toString/-522406933 (var296) String)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun cast-from-var296-to-__Array__Int__var296__ (var296) (Array Int var296))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1426 var1426)
(declare-const var1426-MESSAGE_DATE_FORMATTER var3358)
(declare-const null-var296 var296)
(declare-const null-__Array__Int__var296__ (Array Int var296))
(declare-const var1803 var1426) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var1803 null-var1426)))
(define-const var2622 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2622)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2622!1 String)
(assert (= var2622!1 ""))
(assert true)
(define-const var3167 String (append/672562846 var2622!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var2622!2 String)
(assert (= var2622!2 (str.++ var2622!1 "[")))
(assert true)
(define-const var1794 var643 (getInvocationTime/675231966 var1803)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var1054 var558 (toInstant/-822818885 var1794)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var3428 var2636 var2636_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var3150 var1942 (var1942_ofInstant/129408697 var1054 var3428)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var185 var3358 var1426-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var3610 String (format/372879155 var3150 var185)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var883 String (append/672562846 var3167 var3610)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var3167!1 String)
(assert (= var3167!1 (str.++ var3167 var3610)))
(assert true)
(define-const var1491 String (append/672562846 var883 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var883!1 String)
(assert (= var883!1 (str.++ var883 "] ")))
(assert true)
(define-const var3029 String (append/672562846 var1491 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var1491!1 String)
(assert (= var1491!1 (str.++ var1491 "-> ")))
(assert true)
(define-const var1407 String (append/672562846 var3029 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var3029!1 String)
(assert (= var3029!1 (str.++ var3029 "[")))
(assert true)
(define-const var767 var643 (getOutTime/324948452 var1803)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var1566 var558 (toInstant/-822818885 var767)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var130 var2636 var2636_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var1266 var1942 (var1942_ofInstant/129408697 var1566 var130)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var2419 var3358 var1426-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var814 String (format/372879155 var1266 var2419)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var2731 String (append/672562846 var1407 var814)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var1407!1 String)
(assert (= var1407!1 (str.++ var1407 var814)))
(assert true)
(define-const var2402 String (append/672562846 var2731 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2731!1 String)
(assert (= var2731!1 (str.++ var2731 "] ")))
(assert true)
(define-const var1000 var296 (get/-1007821573 var1803 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var2527 String (append/-1031950772 var2402 var1000)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var2402!1 String)
(assert (str.prefixof var2402 var2402!1))
(assert true)
(define-const var1834 String (append/-1166366385 var2527 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2527!1 String)
(assert (str.prefixof var2527 var2527!1))
(assert true)
(define-const var3587 var296 (get/-1007821573 var1803 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var632 String (append/-1031950772 var1834 var3587)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var1834!1 String)
(assert (str.prefixof var1834 var1834!1))
(assert true)
(define-const var3536 String (append/672562846 var632 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var632!1 String)
(assert (= var632!1 (str.++ var632 " -> ")))
(assert true)
(define-const var581 var296 (get/-1007821573 var1803 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var1764 String (append/-1031950772 var3536 var581)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var3536!1 String)
(assert (str.prefixof var3536 var3536!1))
(assert true)
(define-const var188 String (append/-1166366385 var1764 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1764!1 String)
(assert (str.prefixof var1764 var1764!1))
(assert true)
(define-const var1038 var296 (get/-1007821573 var1803 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var259 String (append/-1031950772 var188 var1038)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var188!1 String)
(assert (str.prefixof var188 var188!1))
(assert true)
;(assert (append/672562846 var259 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var259!1 String)
(assert (= var259!1 (str.++ var259 " - ")))
(assert true)
(define-const var1988 var296 (get/-1007821573 var1803 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (= var1988 null-var296)) ; Cond: $r32 == null 
(define-const var1095 String "") ; Statement: $r47 = "" 
(assert true) ; Non Conditional
(define-const var3722 Bool (var3192_isNotEmpty/-1251449450 var1095)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var3722 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2796 var296 (get/-1007821573 var1803 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var2622!2 var2796)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var2622!3 String)
(assert (str.prefixof var2622!2 var2622!3))
(assert true)
(define-const var2210 var296 (get/-1007821573 var1803 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (not (= var2210 null-var296))) ; Negate: Cond: $r34 == null  
(assert true)
(define-const var2931 var296 (get/-1007821573 var1803 "version")) ; Statement: $r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
(assert true)
(define-const var2211 String (toString/-522406933 var2931)) ; Statement: $r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)] 
(assert true) ; Non Conditional
(define-const var1507 Bool (var3192_isNotEmpty/-1251449450 var2211)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var1507 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var2622!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2622!4 String)
(assert (str.prefixof var2622!3 var2622!4))
(assert true)
(define-const var1534 var296 (get/-1007821573 var1803 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var2622!4 var1534)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var2622!5 String)
(assert (str.prefixof var2622!4 var2622!5))
(assert true)
;(assert (append/-1166366385 var2622!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var2622!6 String)
(assert (str.prefixof var2622!5 var2622!6))
(assert true)
(define-const var3088 var296 (get/-1007821573 var1803 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (= var3088 null-var296)) ; Cond: $r36 == null 
(define-const var1064 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r49 = newarray (java.lang.Class)[0] 
(assert true) ; Non Conditional
(define-const var359 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var2161 (Array Int ClassObject) var1064) ; Statement: r50 = $r49 
(define-const var1116 Int (getLength-Arr-ClassObject-1 var1064)) ; Statement: $i1 = lengthof $r49 
(define-const var409 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var409 var1116)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var2622!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var2622!7 String)
(assert (= var2622!7 (str.++ var2622!6 ") ")))
(assert true)
(define-const var1446 var296 (get/-1007821573 var1803 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (not (= var1446 null-var296))) ; Negate: Cond: $r37 == null  
(assert true)
(define-const var1256 var296 (get/-1007821573 var1803 "arguments")) ; Statement: $r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
(define-const var2174 (Array Int var296) (cast-from-var296-to-__Array__Int__var296__ var1256)) ; Statement: $r51 = (java.lang.Object[]) $r39 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var2174 null-__Array__Int__var296__)) ; Cond: $r51 == null 
(assert true)
(define-const var928 String (toString/-2075883882 var2622!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var2636_systemDefault/1019915793=([], java.time.ZoneId), var1942_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var3192_isNotEmpty/-1251449450=([java.lang.String], boolean), toString/-522406933=([java.lang.Object], java.lang.String), arr-ClassObject-init=([], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), cast-from-var296-to-__Array__Int__var296__=([java.lang.Object], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1426=org.apache.dubbo.rpc.support.AccessLogData, var1803=r1, var2622=$r0, var3167=$r8, var643=java.util.Date, var1794=$r2, var558=java.time.Instant, var1054=$r4, var2636=java.time.ZoneId, var3428=$r3, var1942=java.time.LocalDateTime, var3150=$r6, var3358=java.time.format.DateTimeFormatter, var185=$r5, var3610=$r7, var883=$r9, var1491=$r10, var3029=$r11, var1407=$r18, var767=$r12, var1566=$r14, var130=$r13, var1266=$r16, var2419=$r15, var814=$r17, var2731=$r19, var2402=$r21, var296=java.lang.Object, var1000=$r20, var2527=$r22, var1834=$r24, var3587=$r23, var632=$r25, var3536=$r27, var581=$r26, var1764=$r28, var188=$r30, var1038=$r29, var259=$r31, var1988=$r32, var1095=$r47, var3192=org.apache.dubbo.common.utils.StringUtils, var3722=$z0, var2796=$r33, var2210=$r34, var2931=$r44, var2211=$r48, var1507=$z1, var1534=$r35, var3088=$r36, var1064=$r49, var359=z2, var2161=r50, var1116=$i1, var409=i2, var1446=$r37, var1256=$r39, var2174=$r51, var928=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var1426, r1=var1803, $r0=var2622, $r8=var3167, java.util.Date=var643, $r2=var1794, java.time.Instant=var558, $r4=var1054, java.time.ZoneId=var2636, $r3=var3428, java.time.LocalDateTime=var1942, $r6=var3150, java.time.format.DateTimeFormatter=var3358, $r5=var185, $r7=var3610, $r9=var883, $r10=var1491, $r11=var3029, $r18=var1407, $r12=var767, $r14=var1566, $r13=var130, $r16=var1266, $r15=var2419, $r17=var814, $r19=var2731, $r21=var2402, java.lang.Object=var296, $r20=var1000, $r22=var2527, $r24=var1834, $r23=var3587, $r25=var632, $r27=var3536, $r26=var581, $r28=var1764, $r30=var188, $r29=var1038, $r31=var259, $r32=var1988, $r47=var1095, org.apache.dubbo.common.utils.StringUtils=var3192, $z0=var3722, $r33=var2796, $r34=var2210, $r44=var2931, $r48=var2211, $z1=var1507, $r35=var1534, $r36=var3088, $r49=var1064, z2=var359, r50=var2161, $i1=var1116, i2=var409, $r37=var1446, $r39=var1256, $r51=var2174, $r52=var928}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r47 = "";	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	$r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>();	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r49 = newarray (java.lang.Class)[0];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	$r51 = (java.lang.Object[]) $r39;	goto [?= (branch)];	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14